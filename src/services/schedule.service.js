import { Schedule, ScheduleDetail, Booking } from 'database/models';
import { MINUTES_PER_SESSION } from 'utils/constants';
import moment from 'moment';
import httpStatus from 'http-status';
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
    const isBooked = scheduleDetailInfo.length
      ? scheduleDetailInfo.some(({ bookingInfo }) => bookingInfo.length)
      : false;
    if (acc[date]) {
      acc[date].push({ id, tutorId, startTime, endTime, createdAt, isBooked });
    } else {
      acc[date] = [{ id, tutorId, startTime, endTime, createdAt, isBooked }];
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
      },
    }));
    return item;
  });

  const updateBookingStatus = Promise.all(updateBookingStatusPromises);

  return updateBookingStatus;
};

scheduleService.register = async (tutorId, fields) => {
  const existedSchedules = await Schedule.findAll({
    where: {
      tutorId,
    },
  });

  const { startTime, endTime } = fields;
  const newStartTime = moment(startTime, 'HH:mm');
  const newEndTime = moment(endTime, 'HH:mm');
  const startPeriod = moment(startTime, 'HH:mm').hour();
  const endPeriod = moment(endTime, 'HH:mm').hour();
  const diff = newEndTime.diff(newStartTime, 'minute');
  const isNotDivisible = diff % MINUTES_PER_SESSION !== 0;

  // Check end time greater than start time
  if (newEndTime <= newStartTime)
    throw new ApiError(
      httpStatus.BAD_REQUEST,
      'End time should be greater than start time',
    );

  //Check divisible by MINUTES_PER_SESSION
  if (isNotDivisible)
    throw new ApiError(
      httpStatus.BAD_REQUEST,
      `The period must be divisible by ${MINUTES_PER_SESSION}`,
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
      throw new ApiError(httpStatus.BAD_REQUEST, 'Booking duplicate');
    }
  });

  const schedule = await Schedule.create({
    tutorId,
    ...fields,
  });

  const { id: scheduleId } = schedule;

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
