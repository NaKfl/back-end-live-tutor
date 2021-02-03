import express from 'express';
import tutorController from 'controllers/tutor.controller';
import tutorValidation from 'validations/tutor.validation';
import validate from 'middlewares/validate';

const router = express.Router();

router.get('/', validate(tutorValidation.getMany), tutorController.getMany);

export default router;
