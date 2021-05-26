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
import { PRICE_PER_SESSION_KEY } from 'utils/constants';
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

paymentService.purchase = async (userId, numberOfSession, transaction) => {
  const wallet = await Wallet.findOne({
    where: {
      userId,
      isBlocked: false,
    },
    lock: true,
    transaction,
  });

  if (!wallet)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Your wallet is blocked');

  const currentPricePerSession = await Fee.findOne({
    where: {
      key: PRICE_PER_SESSION_KEY,
    },
  });

  const currentAmount = +wallet.amount;
  const newAmount =
    currentAmount - +currentPricePerSession.price * numberOfSession;
  if (newAmount < 0)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Not enough money');

  const newWallet = await Wallet.update(
    { amount: newAmount },
    {
      where: {
        id: wallet.id,
      },
      lock: true,
      transaction,
      returning: true,
    },
  );

  return {
    wallet: newWallet[1][0],
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
      isBlocked: false,
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
        include: {
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
