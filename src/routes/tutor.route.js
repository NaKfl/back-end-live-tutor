import express from 'express';
import tutorController from 'controllers/tutor.controller';
import tutorValidation from 'validations/tutor.validation';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import upload from 'middlewares/multer';
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
  upload.array('video', 2),
  tutorController.register,
);

router.get('/:id', auth(), tutorController.getOne);

export default router;
