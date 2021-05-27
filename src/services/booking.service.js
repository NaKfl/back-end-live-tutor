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
import { TRANSACTION_TYPES } from 'utils/constants';

const bookingService = {};

bookingService.book = async (userId, scheduleDetailIds, origin) => {
  // Get tutor and student info
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
  const tutor = scheduleDetails?.[0]?.scheduleInfo?.tutorInfo;

  const result = await sequelize.transaction(async (transaction) => {
    const existsBookings = await Booking.findAll({
      where: {
        scheduleDetailId: scheduleDetailIds,
      },
    });

    if (
      existsBookings.length &&
      existsBookings.some((item) => item.isDeleted === false)
    )
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
      student.id,
      tutor.id,
      scheduleDetailIds.length,
      transaction,
    );

    if (!purchase)
      throw new ApiError(httpStatus.BAD_REQUEST, 'Payment system has problems');

    const { buyerWallet, sellerWallet, currentPricePerSession } = purchase;

    const buyerTransactionPromises = bookings.map(async (booking) => {
      return Transaction.create(
        {
          walletId: buyerWallet.id,
          bookingId: booking.id,
          price: -currentPricePerSession,
          status: 'success',
          type: TRANSACTION_TYPES.BUY,
        },
        { transaction },
      );
    });

    await Promise.all(buyerTransactionPromises);

    const sellerTransactionPromises = bookings.map(async (booking) => {
      return Transaction.create(
        {
          walletId: sellerWallet.id,
          bookingId: booking.id,
          price: +currentPricePerSession,
          status: 'success',
          type: TRANSACTION_TYPES.SELL,
        },
        { transaction },
      );
    });

    await Promise.all(sellerTransactionPromises);

    return bookings;
  });

  if (result) {
    //Mailing
    if (student && tutor) {
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
        tutor: tutor.dataValues,
        dates: result,
        roomName,
        startTime,
        isSendTutor: true,
        origin,
      });
      confirmBookingNewSchedule({
        student: student.dataValues,
        tutor: tutor.dataValues,
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
  const result = await sequelize.transaction(async (transaction) => {
    const existsBookings = await Booking.findAll({
      where: {
        scheduleDetailId: scheduleDetailIds,
        isDeleted: false,
      },
      include: [
        {
          model: User,
          as: 'userInfo',
        },
        {
          model: ScheduleDetail,
          as: 'scheduleDetailInfo',
          include: {
            model: Schedule,
            as: 'scheduleInfo',
            include: {
              model: User,
              as: 'tutorInfo',
            },
          },
        },
      ],
    });

    if (existsBookings.length < scheduleDetailIds.length)
      throw new ApiError(httpStatus.NOT_FOUND, 'Booking does not exist');

    const student = existsBookings?.[0]?.userInfo;
    const tutor =
      existsBookings?.[0]?.scheduleDetailInfo?.scheduleInfo?.tutorInfo;

    const ids = existsBookings.map((item) => {
      const { id, userId: userIdBooking } = item;
      if (userIdBooking !== userId)
        throw new ApiError(httpStatus.FORBIDDEN, 'Permission denied');
      return id;
    });

    const refund = await paymentService.refund(
      student.id,
      tutor.id,
      ids.length,
      transaction,
    );

    const transactions = await Transaction.findAll({
      where: {
        bookingId: ids,
      },
    });

    if (!refund)
      throw new ApiError(httpStatus.BAD_REQUEST, 'Payment system has problems');

    const { buyerWallet, sellerWallet, currentPricePerSession } = refund;
    const refundTractionPromises = ids.map((bookingId) => {
      transactions.map((item) => {
        const { type } = item;
        if (type === TRANSACTION_TYPES.BUY) {
          return Transaction.create(
            {
              walletId: buyerWallet.id,
              bookingId: bookingId,
              price: +currentPricePerSession,
              status: 'success',
              type: TRANSACTION_TYPES.CANCEL,
            },
            { transaction },
          );
        }
        if (type === TRANSACTION_TYPES.SELL) {
          return Transaction.create(
            {
              walletId: sellerWallet.id,
              bookingId: bookingId,
              price: -currentPricePerSession,
              status: 'success',
              type: TRANSACTION_TYPES.RETURN,
            },
            { transaction },
          );
        }
      });
      return Promise.all(refundTractionPromises);
    });

    const deletedBookings = await Booking.update(
      { isDeleted: true },
      {
        where: { id: ids },
      },
      transaction,
    );

    return deletedBookings;
  });

  return result;
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
      isDeleted: false,
    },
    ...paginate({ page, perPage }),
    order: [['createdAt', 'DESC']],
  });
  return bookingList;
};

export default bookingService;
