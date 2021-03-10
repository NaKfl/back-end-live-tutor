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

const cpUpload = upload.fields([
  { name: 'avatar', maxCount: 1 },
  { name: 'video', maxCount: 8 },
]);
router.post('/register', auth(), cpUpload, tutorController.register);

router.get('/:id', auth(), tutorController.getOne);

router.get(
  '/list/approval',
  auth(),
  validate(tutorValidation.getWaitingList),
  tutorController.getWaitingList,
);

router.put(
  '/update/approval',
  auth(),
  validate(tutorValidation.updateTutor),
  tutorController.updateTutor,
);

export default router;
