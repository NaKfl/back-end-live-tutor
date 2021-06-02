import { Schedule, ScheduleDetail, Booking } from 'database/models';
import { MINUTES_PER_SESSION, ERROR_CODE } from 'utils/constants';
import moment from 'moment';
import ApiError from 'utils/ApiError';

const scheduleService = {};

scheduleService.getMany = async (tutorId, query = null) => {
  const schedules = await Schedule.findAll({
    where: { tutorId, ...query },
    include: [
      {
        model: ScheduleDetail,
        as: 'scheduleDetailInfo',
        include: [
          {
            model: Booking,
            as: 'bookingInfo',
          },
        ],
      },
    ],
  });

  const formattedSchedules = schedules.reduce((acc, curr) => {
    const {
      date,
      id,
      tutorId,
      startTime,
      endTime,
      createdAt,
      scheduleDetailInfo,
    } = curr;

    let isBooked = false;
    const scheduleDetails = scheduleDetailInfo.map((item) => {
      isBooked =
        item?.bookingInfo?.length > 0 &&
        item.bookingInfo.some((item) => item.isDeleted === false);
      item.dataValues.isBooked = isBooked;
      delete item.dataValues.bookingInfo;
      return item;
    });

    let returnObject = null;
    if (query.date)
      returnObject = {
        id,
        tutorId,
        startTime,
        endTime,
        createdAt,
        isBooked,
        scheduleDetails,
      };
    else
      returnObject = {
        id,
        tutorId,
        startTime,
        endTime,
        createdAt,
        isBooked,
      };

    if (acc[date]) {
      if (query.date) acc[date].push(returnObject);
      else acc[date].push(returnObject);
    } else {
      if (query.date) acc[date] = [returnObject];
      else acc[date] = [returnObject];
    }

    return acc;
  }, {});

  return formattedSchedules;
};

scheduleService.getOne = async (scheduleId) => {
  const scheduleDetails = await ScheduleDetail.findAll({
    where: { scheduleId },
  });

  const updateBookingStatusPromises = scheduleDetails.map(async (item) => {
    const { id } = item;
    item.dataValues.isBooked = !!(await Booking.findOne({
      where: {
        scheduleDetailId: id,
        isDeleted: false,
      },
    }));
    return item;
  });

  const updateBookingStatus = Promise.all(updateBookingStatusPromises);

  return updateBookingStatus;
};

scheduleService.register = async (tutorId, fields) => {
  const { startTime, endTime, date } = fields;

  const existedSchedules = await Schedule.findAll({
    where: {
      tutorId,
      date,
    },
  });

  const newStartTime = moment(startTime, 'HH:mm');
  const newEndTime = moment(endTime, 'HH:mm');
  const startPeriod = moment(startTime, 'HH:mm').hour();
  const startPeriodMinutes = moment(startTime, 'HH:mm').minute();
  console.log('startPeriodMinutes', startPeriodMinutes);
  const diff = newEndTime.diff(newStartTime, 'minute');
  const isNotDivisible = diff % MINUTES_PER_SESSION !== 0;

  // Check end time greater than start time
  if (newEndTime <= newStartTime)
    throw new ApiError(
      ERROR_CODE.END_GREATER_START.code,
      ERROR_CODE.END_GREATER_START.message,
    );

  //Check divisible by MINUTES_PER_SESSION
  if (isNotDivisible)
    throw new ApiError(
      ERROR_CODE.PERIOD_DIVISIABLE_30.code,
      ERROR_CODE.PERIOD_DIVISIABLE_30.message,
    );

  // Check duplicate
  existedSchedules.some((item) => {
    const { startTime, endTime } = item;
    const oldStartTime = moment(startTime, 'HH:mm');
    const oldEndTime = moment(endTime, 'HH:mm');
    if (
      (newStartTime > oldStartTime && newStartTime < oldEndTime) ||
      (newEndTime > oldStartTime && newEndTime < oldEndTime) ||
      (newStartTime <= oldStartTime && newEndTime >= oldEndTime)
    ) {
      throw new ApiError(
        ERROR_CODE.SCHEDULE_DUPLICATE.code,
        ERROR_CODE.SCHEDULE_DUPLICATE.message,
      );
    }
  });

  const schedule = await Schedule.create({
    tutorId,
    ...fields,
  });

  const { id: scheduleId } = schedule;

  const startPeriods = [...Array(diff / MINUTES_PER_SESSION)].map(
    (_, index) => {
      return moment().set({
        hour: startPeriod,
        minute: index * MINUTES_PER_SESSION + startPeriodMinutes,
        second: 0,
      });
    },
  );

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

scheduleService.registerRepeatDays = async (tutorId, fields) => {
  const { startTime, endTime, startDate, endDate } = fields;
  const numOfDays = moment(endDate).diff(moment(startDate), 'days');
  const registerSchedulePromises = [];
  let dateRegister = startDate;
  for (let i = 0; i <= numOfDays; i++) {
    const fields = {
      startTime,
      endTime,
      date: dateRegister,
    };
    registerSchedulePromises.push(scheduleService.register(tutorId, fields));
    dateRegister = moment(dateRegister).add(1, 'days');
  }
  const results = Promise.all(registerSchedulePromises);
  return results;
};

scheduleService.unregister = async (scheduleId) => {
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

export default scheduleService;
