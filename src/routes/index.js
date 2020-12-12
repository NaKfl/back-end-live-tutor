import express from 'express';
import studentRoutes from 'routes/student.route';

const router = express.Router();

// For test does server work :))
router.get('/status', (req, res) =>
  res.json({
    message: 'OK',
  }),
);

router.use('/student', studentRoutes);

export default router;
