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

paymentController.getStatistics = catchAsync(async (req, res) => {
  const {
    user: { id },
  } = req;
  const data = await paymentService.getStatistics({
    userId: id,
  });
  return res.json({ message: 'Get statistics successfully', data });
});

paymentController.getBanks = catchAsync(async (req, res) => {
  const data = paymentService.getBanks();
  return res.json({ message: 'Get banks successfully', data });
});

paymentController.deposit = catchAsync(async (req, res) => {
  const {
    user: { id },
    body: { token },
  } = req;
  const data = await paymentService.deposit(id, token);
  return res.json({ message: 'Deposit successfully', data });
});

paymentController.getPriceOfOneSession = catchAsync(async (req, res) => {
  const data = await paymentService.getPriceOfEachSession();
  res.json(data);
});

paymentController.getPriceOfOneDollar = catchAsync(async (req, res) => {
  const data = await paymentService.getPriceOfOneDollar();
  res.json(data);
});

paymentController.getAll = catchAsync(async (req, res) => {
  const { query } = req;
  const data = await paymentService.getHistoryTransaction(query);
  res.send(data);
});

paymentController.getAllFee = catchAsync(async (req, res) => {
  const data = await paymentService.getFee();
  res.send(data);
});

paymentController.updateFee = catchAsync(async (req, res) => {
  const { price, id } = req.body;
  const data = await paymentService.updateFee({ price, id });
  res.send(data);
});
export default paymentController;
