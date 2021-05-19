import express from 'express';
import userController from 'controllers/user.controller';
import { auth } from 'middlewares/auth';
import userValidation from 'validations/user.validation';
import validate from 'middlewares/validate';
import upload from 'middlewares/multer';
const router = express.Router();

router.get('/info', auth(), userController.getInfo);

router.put(
  '/info',
  auth(),
  validate(userValidation.updateInfo),
  userController.updateInfo,
);

router.get('/favoriteTutor', auth(), userController.getAllFavoriteTutor);

router.post(
  '/manageFavoriteTutor',
  auth(),
  validate(userValidation.manageFavoriteTutor),
  userController.manageFavoriteTutor,
);

router.post(
  '/uploadAvatar',
  auth(),
  upload.single('avatar'),
  userController.updateAvatar,
);

router.post(
  '/feedbackTutor',
  auth(),
  validate(userValidation.feedbackTutor),
  userController.feedbackTutor,
);

router.post(
  '/forgotPassword',
  validate(userValidation.forgotPassword),
  userController.forgotPassword,
);

router.post('/resetpassword', userController.resetPassword);

export default router;
