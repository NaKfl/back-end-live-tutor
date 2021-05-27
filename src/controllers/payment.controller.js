import { paymentService } from 'services';
import catchAsync from 'utils/catchAsync';

const paymentController = {};

paymentController.getWallet = catchAsync(async (req, res) => {
  const {
    user: { id },
  } = req;
  const data = await paymentService.getWallet(id);
  return res.json({ message: 'Get wallet successfully', data });
});

paymentController.getHistory = catchAsync(async (req, res) => {
  const {
    user: { id },
    query: { date, page, perPage },
  } = req;
  const data = await paymentService.getHistory({
    userId: id,
    date,
    page,
    perPage,
  });
  return res.json({ message: "Get transaction's history successfully", data });
});

paymentController.deposit = catchAsync(async (req, res) => {
  const {
    user: { id },
    body: { price },
  } = req;
  const data = await paymentService.deposit(id, price);
  return res.json({ message: 'Deposit successfully', data });
});

paymentController.getPriceOfOneSession = catchAsync(async (req, res) => {
  const data = await paymentService.getPriceOfEachSession();
  res.json(data);
});
export default paymentController;
