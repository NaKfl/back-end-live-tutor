import majorService from 'services/major.service';
import catchAsync from 'utils/catchAsync';

const majorController = {};

majorController.getAll = catchAsync(async (req, res) => {
  const result = await majorService.getAll();
  res.send(result);
});

export default majorController;
