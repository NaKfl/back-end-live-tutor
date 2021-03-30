import { Schedule, ScheduleDetail } from 'database/models';
import { MINUTES_PER_SESSION } from 'utils/constants';
import moment from 'moment';

const schedule = {};

schedule.getMany = async (tutorId) => {
  const schedules = await Schedule.findAll({
    where: { tutorId },
  });

  const formattedSchedules = schedules.reduce((acc, curr) => {
    const { date, id, tutorId, startTime, endTime, createdAt } = curr;
    const formattedDate = moment(date).format('YYYY-MM-DD');
    if (acc[formattedDate]) {
      acc[formattedDate].push({ id, tutorId, startTime, endTime, createdAt });
    } else {
      acc[formattedDate] = [{ id, tutorId, startTime, endTime, createdAt }];
    }
    return acc;
  }, {});

  return formattedSchedules;
};

schedule.getScheduleDetails = async (scheduleId) => {
  const scheduleDetails = await ScheduleDetail.findAll({
    where: { scheduleId },
  });

  return scheduleDetails;
};

schedule.register = async (tutorId, fields) => {
  const schedule = await Schedule.create({
    tutorId,
    ...fields,
  });

  const { id: scheduleId, startTime, endTime } = schedule;

  const startPeriod = moment(startTime).hour();
  const endPeriod = moment(endTime).hour();

  const startPeriods = [
    ...Array(((endPeriod - startPeriod) * 60) / MINUTES_PER_SESSION),
  ].map((_, index) => {
    return moment().set({
      hour: startPeriod,
      minute: index * MINUTES_PER_SESSION,
      second: 0,
    });
  });

  const scheduleDetailPromises = startPeriods.map((startPeriod) =>
    ScheduleDetail.create({
      scheduleId,
      startPeriod: startPeriod.format(),
      endPeriod: startPeriod.add(MINUTES_PER_SESSION, 'minutes'),
    }),
  );

  await Promise.all(scheduleDetailPromises);

  return schedule;
};

schedule.unregister = async (scheduleId) => {
  const deletedScheduleDetails = await ScheduleDetail.findAll({
    where: {
      scheduleId,
    },
  });

  await Promise.all(deletedScheduleDetails.map((item) => item.destroy()));

  const deletedSchedule = await Schedule.destroy({
    where: { id: scheduleId },
  });

  return deletedSchedule;
};

export default schedule;
