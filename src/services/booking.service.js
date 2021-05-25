import {
  sequelize,
  Booking,
  User,
  ScheduleDetail,
  Schedule,
  Transaction,
} from 'database/models';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { confirmBookingNewSchedule } from 'configs/nodemailer';
import { paginate } from 'utils/sequelize';
import { v4 as uuidv4 } from 'uuid';
import moment from 'moment';
import { paymentService } from 'services';

const bookingService = {};

bookingService.book = async (userId, scheduleDetailIds, origin) => {
  const result = await sequelize.transaction(async (transaction) => {
    const existsBookings = await Booking.findAll({
      where: {
        scheduleDetailId: scheduleDetailIds,
      },
    });

    if (existsBookings.length)
      throw new ApiError(httpStatus.BAD_REQUEST, 'Booking already exists');

    const bookingPromises = scheduleDetailIds.map((scheduleDetailId) =>
      Booking.create(
        {
          userId,
          scheduleDetailId,
        },
        { transaction },
      ),
    );

    const bookings = await Promise.all(bookingPromises);

    const purchase = await paymentService.purchase(
      userId,
      scheduleDetailIds.length,
      transaction,
    );

    if (purchase) {
      const { wallet, currentPricePerSession } = purchase;
      const transactionPromises = bookings.map(async (booking) => {
        return Transaction.create(
          {
            walletId: wallet.id,
            bookingId: booking.id,
            price: currentPricePerSession,
            status: 'success',
          },
          { transaction },
        );
      });

      await Promise.all(transactionPromises);

      return bookings;
    }

    return false;
  });

  if (result) {
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

    //Mailing
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
      let result = [];
      let tmp = [dates[0]];
      if (dates.length !== 1) {
        for (let i = 1; i < dates.length; i++) {
          if (dates[i].start === tmp[tmp.length - 1].end) {
            tmp.push(dates[i]);
          } else {
            result.push(tmp);
            tmp = [dates[i]];
          }
          if (i === dates.length - 1) result.push(tmp);
        }
      } else {
        result.push(tmp);
      }

      const roomName = uuidv4();
      const startTime = moment();
      confirmBookingNewSchedule({
        student: student.dataValues,
        tutor: scheduleDetails[0]?.scheduleInfo?.tutorInfo.dataValues,
        dates: result,
        roomName,
        startTime,
        isSendTutor: true,
        origin,
      });
      confirmBookingNewSchedule({
        student: student.dataValues,
        tutor: scheduleDetails[0]?.scheduleInfo?.tutorInfo.dataValues,
        dates: result,
        roomName,
        startTime,
        isSendTutor: false,
        origin,
      });
    }
  }

  return result;
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
