import { Report, User } from 'database/models';
import { paginate } from 'utils/sequelize';

const reportService = {};

reportService.createReport = async (id, data) => {
  const { tutorId, content } = data;
  return await Report.create({
    userId: id,
    tutorId,
    content,
  });
};

reportService.getAll = async ({ page = 1, perPage = 20 }) => {
  return await Report.findAndCountAll({
    include: [
      {
        model: User,
        as: 'userInfo',
      },
      { model: User, as: 'tutorInfo' },
    ],
    ...paginate({ page, perPage }),
  });
};
export default reportService;
