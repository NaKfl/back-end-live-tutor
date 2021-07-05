import catchAsync from 'utils/catchAsync';
import { courseService } from 'services';

const courseController = {};

courseController.getCourses = catchAsync(async (req, res) => {
  const data = await courseService.getCourses();
  res.json({ message: 'Success', data });
});

courseController.getDetailCourse = catchAsync(async (req, res) => {
  const { id: courseId } = req.params;
  const result = await courseService.getDetailCourse(courseId);
  const reponse = result.toJSON();
  const { topics } = reponse;
  const sortTopics = topics.sort((a, b) => a.orderCourse - b.orderCourse);
  const data = {
    ...reponse,
    topics: sortTopics,
  };
  res.json({ message: 'Success', data });
});

courseController.tutorAdd = catchAsync(async (req, res) => {
  const { id: courseId } = req.params;
  const { id: userId } = req.user;
  await courseService.tutorAdd(userId, courseId);
  res.json({ message: 'Tutor add course successfully' });
});

courseController.tutorRemove = catchAsync(async (req, res) => {
  const { id: courseId } = req.params;
  const { id: userId } = req.user;
  await courseService.tutorRemove(userId, courseId);
  res.json({ message: 'Tutor remove course successfully' });
});

export default courseController;
