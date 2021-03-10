import { Tutor, User } from 'database/models';
import { flatObjectsByKeys } from 'utils/common';
import { paginate } from 'utils/sequelize';
import { Op } from 'sequelize';

const tutorService = {};

tutorService.getMany = async (query) => {
  const { page, perPage, search } = query;
  const tutors = await Tutor.findAndCountAll({
    include: [
      {
        model: User,
        attributes: {
          exclude: ['id', 'password'],
        },
        where: {
          name: {
            [Op.iLike]: `%${search}%`,
          },
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

tutorService.getOne = async (userId) => {
  return await Tutor.findOne({
    where: {
      userId,
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

tutorService.getWaitingList = async () => {
  return await Tutor.findAll({
    where: {
      isActivated: false,
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

tutorService.updateTutor = async (fields) => {
  const { userId, ...updatedFields } = fields;
  return await Tutor.update(updatedFields, {
    where: {
      userId,
    },
  });
};
export default tutorService;
