import reportController from 'controllers/report.controller';
import express from 'express';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import reportValidation from 'validations/report.validation';

const router = express.Router();

router.post(
  '/',
  auth(),
  validate(reportValidation.createReport),
  reportController.createReport,
);

export default router;
