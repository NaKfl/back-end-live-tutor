import express from 'express';
import authRoutes from './auth.route';
import tutorRoutes from './tutor.route';
import userRoutes from './user.route';
import scheduleRoutes from './schedule.route';
import bookingRoutes from './booking.route';
import courseRoutes from './course.route';
import callRoutes from './call.route';
import paymentRoutes from './payment.route';
import categoryRoutes from './category.route';
import majorRoutes from './major.route';
import reportRoutes from './report.route';
import feedbackRoutes from './feedback.route';

const router = express.Router();

router.get('/status', (_, res) =>
  res.json({
    message: 'Everything looks good',
  }),
);

router.use('/auth', authRoutes);
router.use('/tutor', tutorRoutes);
router.use('/user', userRoutes);
router.use('/schedule', scheduleRoutes);
router.use('/booking', bookingRoutes);
router.use('/course', courseRoutes);
router.use('/call', callRoutes);
router.use('/payment', paymentRoutes);
router.use('/category', categoryRoutes);
router.use('/major', majorRoutes);
router.use('/report', reportRoutes);
router.use('/feedback', feedbackRoutes);

export default router;
