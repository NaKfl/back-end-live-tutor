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

router.post(
  '/deposit',
  auth(),
  validate(paymentValidation.deposit),
  paymentController.deposit,
);

export default router;
