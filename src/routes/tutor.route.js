import express from 'express';
import tutorController from 'controllers/tutor.controller';
import tutorValidation from 'validations/tutor.validation';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';

const router = express.Router();

router.get(
  '/',
  auth(),
  validate(tutorValidation.getMany),
  tutorController.getMany,
);

router.post(
  '/register',
  auth(),
  validate(tutorValidation.register),
  tutorController.register,
);

export default router;
