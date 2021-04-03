import catchAsync from 'utils/catchAsync';
import { courseService } from 'services';

const courseController = {};

courseController.getCourses = catchAsync(async (req, res) => {
  const data = await courseService.getCourses();
  res.json({ message: 'Success', data });
});

export default courseController;
