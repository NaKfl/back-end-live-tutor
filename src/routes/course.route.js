import express from 'express';
import courseController from 'controllers/course.controller';
import { auth } from 'middlewares/auth';
import validate from 'middlewares/validate';
import tutorCourseValidation from 'validations/tutorCourse.validation';
const router = express.Router();

router.get('/', auth(), courseController.getCourses);
router.get('/:id', auth(), courseController.getDetailCourse);
router.post(
  '/:id',
  auth(),
  validate(tutorCourseValidation.tutorAdd),
  courseController.tutorAdd,
);
router.delete(
  '/:id',
  auth(),
  validate(tutorCourseValidation.tutorRemove),
  courseController.tutorRemove,
);

export default router;
