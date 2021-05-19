import catchAsync from 'utils/catchAsync';
import { bookingService } from 'services';

const bookingController = {};

bookingController.book = catchAsync(async (req, res) => {
  const { user, body } = req;
  const data = await bookingService.book(user?.id, body?.scheduleDetailIds);
  return res.json({ message: 'Book successful', data });
});

bookingController.cancelBooking = catchAsync(async (req, res) => {
  const { user, body } = req;
  await bookingService.cancelBooking(user?.id, body?.scheduleDetailIds);
  return res.json({ message: 'Cancel booking successful' });
});

bookingController.getListBooking = catchAsync(async (req, res) => {
  const { user, query } = req;
  const data = await bookingService.getList({
    userId: user?.id,
    ...query,
  });

  return res.json({ message: 'Cancel booking successful', data });
});

export default bookingController;
