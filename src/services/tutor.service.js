import { Tutor, User } from 'database/models';
import { flatObjectsByKeys } from 'utils/common';
import { paginate } from 'utils/sequelize';

const tutorService = {};

tutorService.getMany = async (query) => {
  const { page, perPage } = query;
  const tutors = await Tutor.findAndCountAll({
    include: [
      {
        model: User,
        attributes: {
          exclude: ['id', 'password'],
        },
      },
    ],
    raw: true,
    nest: true,
    ...paginate({ page, perPage }),
  });

  const rows = flatObjectsByKeys(tutors.rows, ['User']);
  return { ...tutors, rows };
};

tutorService.getOne = async (id) => {
  return await Tutor.findOne({
    where: {
      id,
    },
    include: [
      {
        model: User,
        attributes: {
          exclude: ['id', 'password'],
        },
      },
    ],
  });
};
export default tutorService;
