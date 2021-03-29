import { Schedule, ScheduleDetail } from 'database/models';
import { MINUTES_PER_SESSION } from 'utils/constants';
import moment from 'moment';

const schedule = {};

schedule.getMany = async (tutorId, query = null) => {
  const schedules = await Schedule.findAll({
    where: { tutorId, ...query },
  });

  const formattedSchedules = schedules.reduce((acc, curr) => {
    const { date, id, tutorId, startTime, endTime, createdAt } = curr;
    if (acc[date]) {
      acc[date].push({ id, tutorId, startTime, endTime, createdAt });
    } else {
      acc[date] = [{ id, tutorId, startTime, endTime, createdAt }];
    }
    return acc;
  }, {});

  return formattedSchedules;
};

schedule.register = async (tutorId, fields) => {
  const schedule = await Schedule.create({
    tutorId,
    ...fields,
  });

  const { id: scheduleId, startTime, endTime } = schedule;

  const startPeriod = moment(startTime, 'HH:mm').hour();
  const endPeriod = moment(endTime, 'HH:mm').hour();

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
      startPeriod: startPeriod.format('HH:mm'),
      endPeriod: startPeriod
        .add(MINUTES_PER_SESSION, 'minutes')
        .format('HH:mm'),
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
