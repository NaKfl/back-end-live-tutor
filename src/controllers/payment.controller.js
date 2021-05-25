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

paymentController.deposit = catchAsync(async (req, res) => {
  const {
    user: { id },
    body: { price },
  } = req;
  const data = await paymentService.deposit(id, price);
  return res.json({ message: 'Deposit successfully', data });
});

export default paymentController;
