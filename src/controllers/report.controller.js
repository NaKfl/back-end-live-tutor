import { reportService } from 'services';
import catchAsync from 'utils/catchAsync';

const paymentController = {};

paymentController.createReport = catchAsync(async (req, res) => {
  const {
    user: { id },
    body,
  } = req;
  const data = await reportService.createReport(id, body);
  return res.json({ message: 'Report successfully', data });
});

export default paymentController;
