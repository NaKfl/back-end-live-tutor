import express from 'express';
import authRoutes from './auth.route';
import tutorRoutes from './tutor.route';
import userRoutes from './user.route';

const router = express.Router();

router.get('/status', (req, res) =>
  res.json({
    message: 'OK',
  }),
);

router.use('/auth', authRoutes);
router.use('/tutor', tutorRoutes);
router.use('/user', userRoutes);

export default router;
