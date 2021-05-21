import { Booking, User, ScheduleDetail, Schedule } from 'database/models';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { confirmBookingNewSchedule } from 'configs/nodemailer';
import { paginate } from 'utils/sequelize';
import { v4 as uuidv4 } from 'uuid';
import moment from 'moment';

const bookingService = {};

bookingService.book = async (userId, scheduleDetailIds, origin) => {
  const existsBookings = await Booking.findAll({
    where: {
      scheduleDetailId: scheduleDetailIds,
    },
  });

  if (existsBookings.length)
    throw new ApiError(httpStatus.BAD_REQUEST, 'Booking already exists');

  const bookingPromises = scheduleDetailIds.map((scheduleDetailId) =>
    Booking.create({
      userId,
      scheduleDetailId,
    }),
  );

  const bookings = await Promise.all(bookingPromises);

  const student = await User.findByPk(userId);
  const scheduleDetails = await ScheduleDetail.findAll({
    where: {
      id: scheduleDetailIds,
    },
    include: [
      {
        model: Schedule,
        as: 'scheduleInfo',
        include: [
          {
            model: User,
            as: 'tutorInfo',
          },
        ],
      },
    ],
  });

  if (
    student &&
    scheduleDetails.length &&
    scheduleDetails[0]?.scheduleInfo?.tutorInfo
  ) {
    const dates = scheduleDetails
      .map((item) => {
        const { scheduleInfo, startPeriod, endPeriod } = item;
        const date = moment(scheduleInfo.date, 'YYYY-MM-DD').format(
          'YYYY-MM-DD',
        );
        const start = moment(startPeriod, 'HH:mm').format('HH:mm');
        const end = moment(endPeriod, 'HH:mm').format('HH:mm');
        return {
          date,
          start,
          end,
        };
      })
      .reverse();
    const roomName = uuidv4();
    const startTime = moment();
    confirmBookingNewSchedule({
      student: student.dataValues,
      tutor: scheduleDetails[0]?.scheduleInfo?.tutorInfo.dataValues,
      dates,
      roomName,
      startTime,
      isSendTutor: true,
      origin,
    });
    confirmBookingNewSchedule({
      student: student.dataValues,
      tutor: scheduleDetails[0]?.scheduleInfo?.tutorInfo.dataValues,
      dates,
      roomName,
      startTime,
      isSendTutor: false,
      origin,
    });
  }

  return bookings;
};

bookingService.cancelBooking = async (userId, scheduleDetailIds) => {
  const existsBookings = await Booking.findAll({
    where: {
      scheduleDetailId: scheduleDetailIds,
    },
  });

  if (existsBookings.length < scheduleDetailIds.length)
    throw new ApiError(httpStatus.NOT_FOUND, 'Booking does not exist');

  const ids = existsBookings.map((item) => {
    const { id, userId: userIdBooking } = item;
    if (userIdBooking !== userId)
      throw new ApiError(httpStatus.FORBIDDEN, 'Permission denied');
    return id;
  });

  const deletedBookings = await Booking.destroy({
    where: { id: ids },
  });

  return deletedBookings;
};

bookingService.getList = async ({ userId, page = 1, perPage = 10 }) => {
  const bookingList = await Booking.findAll({
    include: [
      {
        model: ScheduleDetail,
        as: 'scheduleDetailInfo',
        include: [
          {
            model: Schedule,
            as: 'scheduleInfo',
            include: [
              {
                model: User,
                as: 'tutorInfo',
              },
            ],
          },
        ],
      },
    ],
    where: {
      userId,
    },
    ...paginate({ page, perPage }),
    order: [['createdAt', 'DESC']],
  });
  return bookingList;
};

export default bookingService;
