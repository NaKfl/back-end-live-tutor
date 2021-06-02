import {
  sequelize,
  Wallet,
  Fee,
  Transaction,
  Booking,
  ScheduleDetail,
  Schedule,
  User,
} from 'database/models';
import { Op } from 'sequelize';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { paginate } from 'utils/sequelize';
import moment from 'moment';
import { PRICE_PER_SESSION_KEY, TRANSACTION_TYPES } from 'utils/constants';
import { SERVER_URL } from 'configs/vars';
import get from 'lodash/fp/get';
import { getIncomeOutCome } from 'utils/helpers';

const paymentService = {};

paymentService.createWallet = async (userId) => {
  const wallet = await Wallet.create({
    userId,
    amount: 0,
    isBlocked: false,
  });

  return wallet;
};

paymentService.getWallet = async (userId) => {
  const wallet = await Wallet.findOne({
    where: {
      userId,
      isBlocked: false,
    },
  });

  if (!wallet)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Your wallet is blocked');

  return wallet;
};

paymentService.purchase = async (
  buyerId,
  sellerId,
  numberOfSession,
  transaction,
) => {
  const buyerWallet = await Wallet.findOne({
    where: {
      userId: buyerId,
      isBlocked: false,
    },
    lock: true,
    transaction,
  });

  if (!buyerWallet)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Your wallet is blocked');

  const sellerWallet = await Wallet.findOne({
    where: {
      userId: sellerId,
    },
    lock: true,
    transaction,
  });

  const currentPricePerSession = await Fee.findOne({
    where: {
      key: PRICE_PER_SESSION_KEY,
    },
  });

  const currentBuyerAmount = +buyerWallet.amount;
  const newBuyerAmount =
    currentBuyerAmount - +currentPricePerSession.price * numberOfSession;

  const currentSellerAmount = +sellerWallet.amount;
  const newSellerAmount =
    currentSellerAmount + +currentPricePerSession.price * numberOfSession;

  if (newBuyerAmount < 0)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Not enough money');

  const newBuyerWallet = await Wallet.update(
    { amount: newBuyerAmount },
    {
      where: {
        id: buyerWallet.id,
      },
      lock: true,
      transaction,
      returning: true,
    },
  );

  const newSellerWallet = await Wallet.update(
    {
      amount: newSellerAmount,
    },
    {
      where: {
        id: sellerWallet.id,
      },
      lock: true,
      transaction,
      returning: true,
    },
  );

  return {
    buyerWallet: newBuyerWallet[1][0],
    sellerWallet: newSellerWallet[1][0],
    currentPricePerSession: +currentPricePerSession.price,
  };
};

paymentService.refund = async (
  buyerId,
  sellerId,
  numberOfSession,
  transaction,
) => {
  const buyerWallet = await Wallet.findOne({
    where: {
      userId: buyerId,
      isBlocked: false,
    },
    lock: true,
    transaction,
  });

  const sellerWallet = await Wallet.findOne({
    where: {
      userId: sellerId,
    },
    lock: true,
    transaction,
  });

  const currentPricePerSession = await Fee.findOne({
    where: {
      key: PRICE_PER_SESSION_KEY,
    },
  });

  const currentBuyerAmount = +buyerWallet.amount;
  const newBuyerAmount =
    currentBuyerAmount + +currentPricePerSession.price * numberOfSession;

  const currentSellerAmount = +sellerWallet.amount;
  const newSellerAmount =
    currentSellerAmount - +currentPricePerSession.price * numberOfSession;

  if (currentSellerAmount < 0)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Seller amount not enough');

  const newBuyerWallet = await Wallet.update(
    { amount: newBuyerAmount },
    {
      where: {
        id: buyerWallet.id,
      },
      lock: true,
      transaction,
      returning: true,
    },
  );

  const newSellerWallet = await Wallet.update(
    {
      amount: newSellerAmount,
    },
    {
      where: {
        id: sellerWallet.id,
      },
      lock: true,
      transaction,
      returning: true,
    },
  );

  return {
    buyerWallet: newBuyerWallet[1][0],
    sellerWallet: newSellerWallet[1][0],
    currentPricePerSession: +currentPricePerSession.price,
  };
};

paymentService.deposit = async (userId, price) => {
  const result = await sequelize.transaction(async (transaction) => {
    const wallet = await Wallet.findOne({
      where: {
        userId,
        isBlocked: false,
      },
    });

    if (!wallet)
      throw new ApiError(httpStatus.BAD_REQUEST, 'Your wallet is blocked');

    const newAmount = +wallet.amount + price;

    const newWallet = await Wallet.update(
      { amount: newAmount },
      {
        where: {
          id: wallet.id,
        },
        returning: true,
        transaction,
      },
    );

    await Transaction.create({
      walletId: wallet.id,
      price: price,
      status: 'success',
      type: TRANSACTION_TYPES.DEPOSIT,
    });

    return newWallet[1][0];
  });

  return result;
};

paymentService.getHistory = async ({
  userId,
  date = null,
  page = 1,
  perPage = 20,
}) => {
  const wallet = await Wallet.findOne({
    where: {
      userId,
    },
  });

  let where = {
    walletId: wallet.id,
  };

  if (date) {
    const startDate = moment(date).utc();
    const endDate = moment(date).add(1, 'day').utc();
    where = {
      ...where,
      createdAt: {
        [Op.gte]: startDate,
        [Op.lt]: endDate,
      },
    };
  }

  const history = await Transaction.findAndCountAll({
    where,
    include: [
      {
        model: Booking,
        as: 'bookingInfo',
        attributes: {
          exclude: ['userId', 'updatedAt'],
        },
        include: [
          {
            model: User,
            as: 'userInfo',
            attributes: ['id', 'name', 'email', 'avatar'],
          },
          {
            model: ScheduleDetail,
            as: 'scheduleDetailInfo',
            attributes: {
              exclude: ['scheduleId', 'createdAt', 'updatedAt'],
            },
            include: [
              {
                model: Schedule,
                as: 'scheduleInfo',
                include: [
                  {
                    model: User,
                    as: 'tutorInfo',
                    attributes: ['id', 'name', 'email', 'avatar'],
                  },
                ],
              },
            ],
          },
        ],
      },
    ],

    ...paginate({ page, perPage }),
    order: [['createdAt', 'DESC']],
  });

  const formattedHistory = history.rows.map((item) => {
    const tutor = get(
      'bookingInfo.scheduleDetailInfo.scheduleInfo.tutorInfo',
      item,
    );

    if (tutor) {
      delete item.bookingInfo.scheduleDetailInfo.dataValues.scheduleInfo;
      item.bookingInfo.scheduleDetailInfo.dataValues.tutorInfo = tutor;
    }

    return item;
  });

  return { count: history.count, rows: formattedHistory };
};

paymentService.getStatistics = async ({ userId }) => {
  const wallet = await Wallet.findOne({
    where: {
      userId,
    },
  });

  let where = {
    walletId: wallet.id,
  };

  const history = await Transaction.findAll({
    where,
    include: [
      {
        model: Booking,
        as: 'bookingInfo',
        attributes: {
          exclude: ['userId', 'updatedAt'],
        },
        include: [
          {
            model: User,
            as: 'userInfo',
            attributes: ['id', 'name', 'email', 'avatar'],
          },
          {
            model: ScheduleDetail,
            as: 'scheduleDetailInfo',
            attributes: {
              exclude: ['scheduleId', 'createdAt', 'updatedAt'],
            },
            include: [
              {
                model: Schedule,
                as: 'scheduleInfo',
                include: [
                  {
                    model: User,
                    as: 'tutorInfo',
                    attributes: ['id', 'name', 'email', 'avatar'],
                  },
                ],
              },
            ],
          },
        ],
      },
    ],
    order: [['createdAt', 'ASC']],
  });

  const statistics = getIncomeOutCome(history);
  return statistics;
};

paymentService.getPriceOfEachSession = async () => {
  return await Fee.findOne({
    where: {
      key: PRICE_PER_SESSION_KEY,
    },
  });
};

paymentService.getBanks = () => {
  return [
    {
      id: '1',
      bankCode: 'VNPAYQR',
      bankName: 'Ngân hàng VNPAYQR',
      bankLogo: `${SERVER_URL}/banks/vnpay.jpg`,
    },
    {
      id: '2',
      bankCode: 'NCB',
      bankName: 'Ngân hàng NCB',
      bankLogo: `${SERVER_URL}/banks/ncb.png`,
    },
    {
      id: '3',
      bankCode: 'SCB',
      bankName: 'Ngân hàng SCB',
      bankLogo: `${SERVER_URL}/banks/scb.png`,
    },
    {
      id: '4',
      bankCode: 'SACOMBANK',
      bankName: 'Ngân hàng SACOMBANK',
      bankLogo: `${SERVER_URL}/banks/sacombank.png`,
    },
    {
      id: '5',
      bankCode: 'EXIMBANK',
      bankName: 'Ngân hàng EXIMBANK',
      bankLogo: `${SERVER_URL}/banks/eximbank.png`,
    },
    {
      id: '6',
      bankCode: 'MSBANK',
      bankName: 'Ngân hàng MSBANK',
      bankLogo: `${SERVER_URL}/banks/msbank.png`,
    },
    {
      id: '7',
      bankCode: 'NAMABANK',
      bankName: 'Ngân hàng NAMABANK',
      bankLogo: `${SERVER_URL}/banks/namabank.png`,
    },
    {
      id: '8',
      bankCode: 'VISA',
      bankName: 'Ngân hàng VISA',
      bankLogo: `${SERVER_URL}/banks/visa.png`,
    },
    {
      id: '9',
      bankCode: 'VNMART',
      bankName: 'Ngân hàng VNMART',
      bankLogo: `${SERVER_URL}/banks/vnmart.png`,
    },
    {
      id: '10',
      bankCode: 'VIETINBANK',
      bankName: 'Ngân hàng VIETINBANK',
      bankLogo: `${SERVER_URL}/banks/vietinbank.png`,
    },
    {
      id: '11',
      bankCode: 'VIETCOMBANK',
      bankName: 'Ngân hàng VIETCOMBANK',
      bankLogo: `${SERVER_URL}/banks/vietcombank.png`,
    },
    {
      id: '12',
      bankCode: 'HDBANK',
      bankName: 'Ngân hàng HDBANK',
      bankLogo: `${SERVER_URL}/banks/hdbank.png`,
    },
    {
      id: '13',
      bankCode: 'DONGABANK',
      bankName: 'Ngân hàng Dong A',
      bankLogo: `${SERVER_URL}/banks/dongabank.png`,
    },
    {
      id: '14',
      bankCode: 'TPBANK',
      bankName: 'Ngân hàng TPBANK',
      bankLogo: `${SERVER_URL}/banks/tpbank.png`,
    },
    {
      id: '15',
      bankCode: 'OJB',
      bankName: 'Ngân hàng OceanBank',
      bankLogo: `${SERVER_URL}/banks/ojb.png`,
    },
    {
      id: '17',
      bankCode: 'BIDV',
      bankName: 'Ngân hàng BIDV',
      bankLogo: `${SERVER_URL}/banks/bidv.png`,
    },
    {
      id: '18',
      bankCode: 'TECHCOMBANK',
      bankName: 'Ngân hàng TECHCOMBANK',
      bankLogo: `${SERVER_URL}/banks/techcombank.png`,
    },
    {
      id: '19',
      bankCode: 'VPBANK',
      bankName: 'Ngân hàng VPBANK',
      bankLogo: `${SERVER_URL}/banks/vpbank.png`,
    },
    {
      id: '20',
      bankCode: 'AGRIBANK',
      bankName: 'Ngân hàng AGRIBANK',
      bankLogo: `${SERVER_URL}/banks/agribank.png`,
    },
    {
      id: '21',
      bankCode: 'MBBANK',
      bankName: 'Ngân hàng MBBANK',
      bankLogo: `${SERVER_URL}/banks/mbbank.png`,
    },
    {
      id: '22',
      bankCode: 'ACB',
      bankName: 'Ngân hàng ACB',
      bankLogo: `${SERVER_URL}/banks/acb.png`,
    },
    {
      id: '23',
      bankCode: 'OCB',
      bankName: 'Ngân hàng OCB',
      bankLogo: `${SERVER_URL}/banks/ocb.png`,
    },
    {
      id: '24',
      bankCode: 'SHB',
      bankName: 'Ngân hàng SHB',
      bankLogo: `${SERVER_URL}/banks/shb.png`,
    },
    {
      id: '25',
      bankCode: 'IVB',
      bankName: 'Ngân hàng IVB',
      bankLogo: `${SERVER_URL}/banks/ivb.png`,
    },
  ];
};

export default paymentService;
