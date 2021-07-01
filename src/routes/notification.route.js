import express from 'express';
import validate from 'middlewares/validate';
import notificationValidation from 'validations/notification.validation';
import notificationController from 'controllers/notification.controller';

const router = express.Router();

router.post(
  '/',
  validate(notificationValidation.addMessage),
  notificationController.addMessage,
);

router.post(
  '/register',
  validate(notificationValidation.registerToken),
  notificationController.registerToken,
);

export default router;
