import { Wallet, Fee } from 'database/models';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { PRICE_PER_SESSION_KEY } from 'utils/constants';

const paymentService = {};

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
    },
  );

  return newWallet[1][0];
};

export default paymentService;
