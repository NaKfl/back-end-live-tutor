import categoryService from 'services/category.service';
import catchAsync from 'utils/catchAsync';

const categoryController = {};

categoryController.getAllByType = catchAsync(async (req, res) => {
  const { type } = req.query;
  await categoryService.checkTypeHaveInTypeModel(type);
  const result = await categoryService.getAllByType(type);
  res.send(result);
});

export default categoryController;
