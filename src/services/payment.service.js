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
import get from 'lodash/fp/get';

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

export default paymentService;
