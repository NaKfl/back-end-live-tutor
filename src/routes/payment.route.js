import paymentController from 'controllers/payment.controller';
import express from 'express';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import paymentValidation from 'validations/payment.validation';

const router = express.Router();

router.get(
  '/wallet',
  auth(),
  validate(paymentValidation.getWallet),
  paymentController.getWallet,
);

router.get(
  '/history',
  auth(),
  validate(paymentValidation.getHistory),
  paymentController.getHistory,
);

router.get(
  '/statistics',
  auth(),
  validate(paymentValidation.getStatistics),
  paymentController.getStatistics,
);

router.get('/banks', auth(), paymentController.getBanks);

router.post(
  '/deposit',
  auth(),
  validate(paymentValidation.deposit),
  paymentController.deposit,
);

router.get('/price-of-session', paymentController.getPriceOfOneSession);

router.get('/price-of-dollar', paymentController.getPriceOfOneDollar);

router.get('/all', paymentController.getAll);
export default router;
