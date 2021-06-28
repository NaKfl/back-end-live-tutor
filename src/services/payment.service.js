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
import ApiError from 'utils/ApiError';
import { paginate } from 'utils/sequelize';
import moment from 'moment';
import {
  PRICE_PER_SESSION_KEY,
  TRANSACTION_TYPES,
  ERROR_CODE,
  PRICE_PER_DOLLAR,
  DEFAULT_PRICE_PER_DOLLAR,
} from 'utils/constants';
import { SERVER_URL, jwt as jwtVars } from 'configs/vars';
import get from 'lodash/fp/get';
import { getIncomeOutCome } from 'utils/helpers';
import jwt from 'jsonwebtoken';

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
    throw new ApiError(
      ERROR_CODE.WALLET_BLOCKED.code,
      ERROR_CODE.WALLET_BLOCKED.message,
    );

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
    throw new ApiError(
      ERROR_CODE.WALLET_BLOCKED.code,
      ERROR_CODE.WALLET_BLOCKED.message,
    );

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
    throw new ApiError(
      ERROR_CODE.NOT_ENOUGH_MONEY.code,
      ERROR_CODE.NOT_ENOUGH_MONEY.message,
    );

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
    throw new ApiError(
      ERROR_CODE.SELLER_NOT_ENOUGH.code,
      ERROR_CODE.SELLER_NOT_ENOUGH.message,
    );

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

paymentService.deposit = async (userId, token) => {
  const result = await sequelize.transaction(async (transaction) => {
    const wallet = await Wallet.findOne({
      where: {
        userId,
        isBlocked: false,
      },
    });

    const decoded = (() => {
      try {
        const decoded = jwt.verify(token, jwtVars.secret);
        return decoded;
      } catch (err) {
        throw new ApiError(
          ERROR_CODE.INVALID_TOKEN.code,
          ERROR_CODE.INVALID_TOKEN.message,
        );
      }
    })();

    const price = decoded?.price;
    const id = decoded?.id;

    if (!wallet)
      throw new ApiError(
        ERROR_CODE.WALLET_BLOCKED.code,
        ERROR_CODE.WALLET_BLOCKED.message,
      );

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

    const existedTransaction = await Transaction.findByPk(id);

    if (existedTransaction) {
      throw new ApiError(
        ERROR_CODE.DEPOSIT_REJECTED.code,
        ERROR_CODE.DEPOSIT_REJECTED.message,
      );
    }

    await Transaction.create({
      id,
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

paymentService.getPriceOfOneDollar = async () => {
  const perPriceDollar = await Fee.findOne({
    where: {
      key: PRICE_PER_DOLLAR,
    },
  });
  return perPriceDollar || DEFAULT_PRICE_PER_DOLLAR;
};

paymentService.getBanks = () => {
  return [
    {
      id: '1',
      bankCode: 'VNPAYQR',
      bankName: 'VNPAYQR',
      bankLogo: `${SERVER_URL}/banks/vnpay.jpg`,
    },
    {
      id: '2',
      bankCode: 'NCB',
      bankName: 'NCB',
      bankLogo: `${SERVER_URL}/banks/ncb.png`,
    },
    {
      id: '3',
      bankCode: 'SCB',
      bankName: 'SCB',
      bankLogo: `${SERVER_URL}/banks/scb.png`,
    },
    {
      id: '4',
      bankCode: 'SACOMBANK',
      bankName: 'SACOMBANK',
      bankLogo: `${SERVER_URL}/banks/sacombank.png`,
    },
    {
      id: '5',
      bankCode: 'EXIMBANK',
      bankName: 'EXIMBANK',
      bankLogo: `${SERVER_URL}/banks/eximbank.png`,
    },
    {
      id: '6',
      bankCode: 'MSBANK',
      bankName: 'MSBANK',
      bankLogo: `${SERVER_URL}/banks/msbank.png`,
    },
    {
      id: '7',
      bankCode: 'NAMABANK',
      bankName: 'NAMABANK',
      bankLogo: `${SERVER_URL}/banks/namabank.png`,
    },
    {
      id: '8',
      bankCode: 'VISA',
      bankName: 'VISA',
      bankLogo: `${SERVER_URL}/banks/visa.png`,
    },
    {
      id: '9',
      bankCode: 'VNMART',
      bankName: 'VNMART',
      bankLogo: `${SERVER_URL}/banks/vnmart.png`,
    },
    {
      id: '10',
      bankCode: 'VIETINBANK',
      bankName: 'VIETINBANK',
      bankLogo: `${SERVER_URL}/banks/vietinbank.png`,
    },
    {
      id: '11',
      bankCode: 'VIETCOMBANK',
      bankName: 'VIETCOMBANK',
      bankLogo: `${SERVER_URL}/banks/vietcombank.png`,
    },
    {
      id: '12',
      bankCode: 'HDBANK',
      bankName: 'HDBANK',
      bankLogo: `${SERVER_URL}/banks/hdbank.png`,
    },
    {
      id: '13',
      bankCode: 'DONGABANK',
      bankName: 'Dong A',
      bankLogo: `${SERVER_URL}/banks/dongabank.png`,
    },
    {
      id: '14',
      bankCode: 'TPBANK',
      bankName: 'TPBANK',
      bankLogo: `${SERVER_URL}/banks/tpbank.png`,
    },
    {
      id: '15',
      bankCode: 'OJB',
      bankName: 'OceanBank',
      bankLogo: `${SERVER_URL}/banks/ojb.png`,
    },
    {
      id: '17',
      bankCode: 'BIDV',
      bankName: 'BIDV',
      bankLogo: `${SERVER_URL}/banks/bidv.png`,
    },
    {
      id: '18',
      bankCode: 'TECHCOMBANK',
      bankName: 'TECHCOMBANK',
      bankLogo: `${SERVER_URL}/banks/techcombank.png`,
    },
    {
      id: '19',
      bankCode: 'VPBANK',
      bankName: 'VPBANK',
      bankLogo: `${SERVER_URL}/banks/vpbank.png`,
    },
    {
      id: '20',
      bankCode: 'AGRIBANK',
      bankName: 'AGRIBANK',
      bankLogo: `${SERVER_URL}/banks/agribank.png`,
    },
    {
      id: '21',
      bankCode: 'MBBANK',
      bankName: 'MBBANK',
      bankLogo: `${SERVER_URL}/banks/mbbank.png`,
    },
    {
      id: '22',
      bankCode: 'ACB',
      bankName: 'ACB',
      bankLogo: `${SERVER_URL}/banks/acb.png`,
    },
    {
      id: '23',
      bankCode: 'OCB',
      bankName: 'OCB',
      bankLogo: `${SERVER_URL}/banks/ocb.png`,
    },
    {
      id: '24',
      bankCode: 'SHB',
      bankName: 'SHB',
      bankLogo: `${SERVER_URL}/banks/shb.png`,
    },
    {
      id: '25',
      bankCode: 'IVB',
      bankName: 'IVB',
      bankLogo: `${SERVER_URL}/banks/ivb.png`,
    },
  ];
};

paymentService.getHistoryTransaction = async () => {
  return await Transaction.findAndCountAll({
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
    ...paginate({ page: 1, perPage: 15 }),
  });
};

export default paymentService;
