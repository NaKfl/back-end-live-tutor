import express from 'express';
import userController from 'controllers/user.controller';
import { auth } from 'middlewares/auth';
import userValidation from 'validations/user.validation';
import validate from 'middlewares/validate';

const router = express.Router();

router.get('/info', auth(), userController.getInfo);
router.put(
  '/info',
  auth(),
  validate(userValidation.updateInfo),
  userController.updateInfo,
);

export default router;
