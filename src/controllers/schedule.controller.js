import catchAsync from 'utils/catchAsync';
import { scheduleService } from 'services';

const scheduleController = {};

scheduleController.getMany = catchAsync(async (req, res) => {
  const { user, query, body } = req;
  const { tutorId } = body;
  let data = null;
  if (tutorId) data = await scheduleService.getMany(tutorId, query);
  else data = await scheduleService.getMany(user?.id, query);
  if (query?.date) {
    data = Object.values(data)[0];
    const listScheduleDetails = data[0].scheduleDetails;

    const sortedArray = listScheduleDetails.sort((a, b) => {
      const timeCur = a.startPeriod.split(':');
      const timeNext = b.startPeriod.split(':');
      return parseInt(timeCur[0]) - parseInt(timeNext[0]);
    });
    data[0].scheduleDetails = sortedArray;
  }
  return res.json({ message: 'Get schedules successful', data });
});

scheduleController.getOne = catchAsync(async (req, res) => {
  const { params } = req;
  const data = await scheduleService.getOne(params?.scheduleId);
  return res.json({ message: 'Get schedule details successful', data });
});

scheduleController.register = catchAsync(async (req, res) => {
  const { user, body } = req;
  const { isRepeated } = body;
  let data;
  if (isRepeated) {
    data = await scheduleService.registerRepeatDays(user?.id, body);
  } else {
    data = await scheduleService.register(user?.id, body);
  }
  return res.json({ message: 'Register schedule successful', data });
});

scheduleController.unregister = catchAsync(async (req, res) => {
  const { params } = req;
  const isDeleted = await scheduleService.unregister(params?.scheduleId);
  if (isDeleted) return res.json({ message: 'Unregister schedule successful' });
  return res.json({ message: `Can't unregister this schedule` });
});

export default scheduleController;
