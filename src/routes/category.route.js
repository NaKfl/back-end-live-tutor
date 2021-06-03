import { Router } from 'express';
import categoryController from 'controllers/category.controller';
import { auth } from 'middlewares/auth';
const router = Router();

router.get('/', auth(), categoryController.getAllByType);

export default router;
