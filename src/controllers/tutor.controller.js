import catchAsync from 'utils/catchAsync';
import { tutorService } from 'services';

const tutorController = {};

tutorController.getMany = catchAsync(async (req, res) => {
  const { query } = req;
  const tutors = await tutorService.getMany(query);
  res.json({ tutors });
});

export default tutorController;
