import express from 'express';
import authRoutes from './auth.route';

const router = express.Router();

router.get('/status', (req, res) =>
  res.json({
    message: 'OK',
  }),
);

router.use('/auth', authRoutes);

export default router;
