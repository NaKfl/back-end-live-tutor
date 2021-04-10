import { Course, Topic, sequelize } from 'database/models';
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
    ],
    where: {
      id,
    },
  });
  return courses;
};

export default courseService;
