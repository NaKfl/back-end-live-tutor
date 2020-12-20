import express from 'express';
import authRoutes from './auth.route';
import tutorRoutes from './tutor.route';

const router = express.Router();

router.get('/status', (req, res) =>
  res.json({
    message: 'OK',
  }),
);

router.use('/auth', authRoutes);
router.use('/tutor', tutorRoutes);

export default router;
