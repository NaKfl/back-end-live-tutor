import { Router } from 'express';
import userController from 'controllers/user.controller';
import { auth } from 'middlewares/auth';
const router = Router();

router.post('/save', auth(), userController.endCall);
router.get('/history', auth(), userController.getCallSessionHistory);
export default router;
