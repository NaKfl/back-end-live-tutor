import scheduleController from 'controllers/schedule.controller';
import express from 'express';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import { ROLES } from 'utils/constants';
import scheduleValidation from 'validations/schedule.validation';

const router = express.Router();

router.get(
  '/free-time/:scheduleId',
  auth(ROLES.TUTOR),
  validate(scheduleValidation.getScheduleDetails),
  scheduleController.getScheduleDetails,
);

router.get('/free-time', auth(ROLES.TUTOR), scheduleController.getMany);

router.post(
  '/free-time',
  auth(ROLES.TUTOR),
  validate(scheduleValidation.register),
  scheduleController.register,
);

router.delete(
  '/free-time',
  auth(ROLES.TUTOR),
  validate(scheduleValidation.unregister),
  scheduleController.unregister,
);

export default router;
