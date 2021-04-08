import catchAsync from 'utils/catchAsync';
import { courseService } from 'services';

const courseController = {};

courseController.getCourses = catchAsync(async (req, res) => {
  const data = await courseService.getCourses();
  res.json({ message: 'Success', data });
});

courseController.getDetailCourse = catchAsync(async (req, res) => {
  const { id: courseId } = req.params;
  const data = await courseService.getDetailCourse(courseId);
  res.json({ message: 'Success', data });
});

export default courseController;
