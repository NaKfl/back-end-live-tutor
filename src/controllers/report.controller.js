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

paymentController.getAll = catchAsync(async (req, res) => {
  const { query } = req;
  const { page, perPage } = query;
  const result = await reportService.getAll({ page, perPage });
  return res.send(result);
});

export default paymentController;
