import scheduleController from 'controllers/schedule.controller';
import express from 'express';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import { ROLES } from 'utils/constants';
import scheduleValidation from 'validations/schedule.validation';

const router = express.Router();

router.get(
  '/:scheduleId',
  auth(ROLES.TUTOR),
  validate(scheduleValidation.getOne),
  scheduleController.getOne,
);

router.post(
  '/',
  auth(),
  validate(scheduleValidation.getMany),
  scheduleController.getMany,
);

router.post(
  '/',
  auth(ROLES.TUTOR),
  validate(scheduleValidation.register),
  scheduleController.register,
);

router.delete(
  '/:scheduleId',
  auth(ROLES.TUTOR),
  validate(scheduleValidation.unregister),
  scheduleController.unregister,
);

export default router;
