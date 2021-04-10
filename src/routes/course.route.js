import express from 'express';
import courseController from 'controllers/course.controller';
import { auth } from 'middlewares/auth';
const router = express.Router();

router.get('/', auth(), courseController.getCourses);
router.get('/:id', auth(), courseController.getDetailCourse);

export default router;
