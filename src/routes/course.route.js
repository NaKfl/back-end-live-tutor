import express from 'express';
import courseController from 'controllers/course.controller';
import { auth } from 'middlewares/auth';
const router = express.Router();

router.get('/', auth(), courseController.getCourses);

export default router;
