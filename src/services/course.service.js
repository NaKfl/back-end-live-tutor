import { Course, Topic, sequelize } from 'database/models';

const courseService = {};

courseService.getCourses = async () => {
  const courses = await Course.findAll({
    attributes: [
      '*',
      [sequelize.fn('COUNT', sequelize.col('topics.courseId')), 'topicCount'],
    ],
    group: [sequelize.col('Course.id')],
    include: [
      {
        model: Topic,
        as: 'topics',
        attributes: [],
      },
    ],
    raw: true,
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
