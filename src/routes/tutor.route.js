import express from 'express';
import tutorController from 'controllers/tutor.controller';
import tutorValidation from 'validations/tutor.validation';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import upload from 'middlewares/multer';
const router = express.Router();

router.get(
  '/all',
  auth(),
  validate(tutorValidation.getMany),
  tutorController.getMany,
);

router.get(
  '/more',
  auth(),
  validate(tutorValidation.getMany),
  tutorController.getMore,
);

const cpUpload = upload.fields([
  { name: 'avatar', maxCount: 1 },
  { name: 'video', maxCount: 1 },
]);
router.post('/register', auth(), cpUpload, tutorController.register);

router.get('/detail/:id', tutorController.getDetailInAdmin);

router.get('/:id', auth(), tutorController.getOne);

router.post('/', auth(), cpUpload, tutorController.updateOne);

router.get('/rank/:num', auth(), tutorController.getListRankTutor);

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
  tutorController.acceptedTutor,
);

router.post('/search', auth(), tutorController.searchTutor);
router.post('/tutor', tutorController.block);
export default router;
