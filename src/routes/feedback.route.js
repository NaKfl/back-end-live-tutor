import express from 'express';
import userController from 'controllers/user.controller';
import { auth } from 'middlewares/auth';
import userValidation from 'validations/user.validation';
import validate from 'middlewares/validate';
const router = express.Router();

router.post(
  '/',
  auth(),
  validate(userValidation.feedbackTutor),
  userController.feedbackTutor,
);

router.get('/:id', auth(), userController.getAllFeedbacks);

router.get('/session/:id', auth(), userController.getSessionFeedback);

export default router;
