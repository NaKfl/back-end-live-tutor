import { Booking } from 'database/models';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';

const bookingService = {};

bookingService.book = async (userId, scheduleDetailIds) => {
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

export default bookingService;
