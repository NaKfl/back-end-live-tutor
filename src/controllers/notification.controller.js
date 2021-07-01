import catchAsync from 'utils/catchAsync';
import { notificationService } from 'services';

const notificationController = {};

notificationController.addMessage = catchAsync(async (req, res) => {
  await notificationService.addMessage(req.body);

  return res.json({
    message: 'Send notification successfully',
  });
});

notificationController.registerToken = catchAsync(async (req, res) => {
  await notificationService.registerToken(req.body);

  return res.json({
    message: 'Register notification successfully',
  });
});

export default notificationController;
