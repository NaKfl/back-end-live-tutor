import express from 'express';
import authRoutes from './auth.route';
import tutorRoutes from './tutor.route';
import userRoutes from './user.route';
import scheduleRoutes from './schedule.route';

const router = express.Router();

router.get('/status', (req, res) =>
  res.json({
    message: 'OK',
  }),
);

router.use('/auth', authRoutes);
router.use('/tutor', tutorRoutes);
router.use('/user', userRoutes);
router.use('/schedule', scheduleRoutes);

export default router;
