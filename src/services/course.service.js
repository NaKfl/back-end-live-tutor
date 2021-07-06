import { Course, Topic, User } from 'database/models';
import ApiError from 'utils/ApiError';
import { ERROR_CODE } from 'utils/constants';
import { paginate } from 'utils/sequelize';
const courseService = {};

courseService.getCourses = async () => {
  const page = 1;
  const perPage = 20;
  const courses = await Course.findAll({
    include: [
      {
        model: Topic,
        as: 'topics',
      },
    ],
    ...paginate({ page, perPage }),
  });
  return courses;
};

courseService.getDetailCourse = async (id) => {
  const courses = await Course.findOne({
    include: [
      {
        model: Topic,
        as: 'topics',
      },
      {
        model: User,
        as: 'users',
      },
    ],
    where: {
      id,
    },
  });
  return courses;
};

courseService.tutorAdd = async (userId, courseId) => {
  const user = await User.findByPk(userId);
  const course = await Course.findByPk(courseId);

  if (await user.hasCourse(course))
    throw new ApiError(
      ERROR_CODE.TUTOR_ALREADY_REGISTERED_COURSE.code,
      ERROR_CODE.TUTOR_ALREADY_REGISTERED_COURSE.message,
    );

  return await user.addCourse(course);
};

courseService.tutorRemove = async (userId, courseId) => {
  const user = await User.findByPk(userId);
  const course = await Course.findByPk(courseId);

  if (!(await user.hasCourse(course))) {
    throw new ApiError(
      ERROR_CODE.TUTOR_NOT_ALREADY_REGISTERED_COURSE.code,
      ERROR_CODE.TUTOR_NOT_ALREADY_REGISTERED_COURSE.message,
    );
  }

  return await user.removeCourse(course);
};

export default courseService;
