import catchAsync from 'utils/catchAsync';
import { scheduleService } from 'services';

const scheduleController = {};

scheduleController.getMany = catchAsync(async (req, res) => {
  const { user, query } = req;
  const data = await scheduleService.getMany(user?.id, query);
  return res.json({ message: 'Get schedules successful', data });
});

scheduleController.getOne = catchAsync(async (req, res) => {
  const { params } = req;
  const data = await scheduleService.getOne(params?.scheduleId);
  return res.json({ message: 'Get schedule details successful', data });
});

scheduleController.register = catchAsync(async (req, res) => {
  const { user, body } = req;
  const data = await scheduleService.register(user?.id, body);
  return res.json({ message: 'Register schedule successful', data });
});

scheduleController.unregister = catchAsync(async (req, res) => {
  const { params } = req;
  const isDeleted = await scheduleService.unregister(params?.scheduleId);
  if (isDeleted) return res.json({ message: 'Unregister schedule successful' });
  return res.json({ message: 'Unregister schedule failed' });
});

export default scheduleController;
