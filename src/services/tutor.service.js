import { Tutor, User } from 'database/models';
import { flatObjectsByKeys } from 'utils/common';
import { paginate } from 'utils/sequelize';
import { Op } from 'sequelize';

const tutorService = {};

tutorService.getMany = async (query) => {
  const { page, perPage, search } = query;
  let where = {};
  if (search) {
    where = {
      name: {
        [Op.iLike]: `%${search}%`,
      },
    };
  }
  const tutors = await Tutor.findAndCountAll({
    where: {
      isActivated: true,
    },
    include: [
      {
        model: User,
        attributes: {
          exclude: ['id', 'password'],
        },
        where,
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

tutorService.createWithUserId = async (fields, userId, avatar, video) => {
  console.log({ fields });
  const isExist = await Tutor.findOne({
    where: {
      userId,
    },
  });
  if (isExist) {
    throw new Error('User have already been a tutor');
  } else {
    const { name, country, birthday, ...othersInfo } = fields;
    await User.update(
      { name, country, birthday, avatar },
      {
        where: {
          id: userId,
        },
      },
    );
    const { languages, specialties, ...textValues } = othersInfo;
    return await Tutor.create({
      ...textValues,
      languages: languages.split(', '),
      specialties: specialties.split(', '),
      video,
      userId,
    });
  }
};
export default tutorService;
