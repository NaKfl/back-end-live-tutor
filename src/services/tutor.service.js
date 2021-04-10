import { Tutor, User, TutorFeedback, FavoriteTutor } from 'database/models';
import { paginate } from 'utils/sequelize';
import { Op } from 'sequelize';
import { onlineUsers } from 'sockets/controllers';

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
        include: [
          {
            model: TutorFeedback,
            as: 'feedbacks',
            include: [
              {
                model: User,
                as: 'firstInfo',
                attributes: {
                  exclude: ['id', 'password'],
                },
              },
            ],
          },
        ],
        where,
      },
    ],
    ...paginate({ page, perPage }),
  });

  const promises = tutors.rows.map(async (tutor) => {
    const user = tutor.User;
    const groupUser = { ...user.dataValues, ...tutor.dataValues };
    groupUser.isOnline = await onlineUsers.isUserOnline(tutor.userId);
    delete groupUser.User;
    return groupUser;
  });

  const result = await Promise.all(promises);
  return { ...tutors, rows: result };
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
        include: [
          {
            model: TutorFeedback,
            as: 'feedbacks',
            include: [
              {
                model: User,
                as: 'firstInfo',
                attributes: {
                  exclude: ['id', 'password'],
                },
              },
            ],
          },
        ],
      },
    ],
  });
};

tutorService.checkIsFavoriteTutorByUserId = async (firstId, secondId) => {
  const favoriteTutorData = await FavoriteTutor.findOne({
    where: {
      firstId,
      secondId,
    },
  });

  if (favoriteTutorData) {
    return true;
  }

  return false;
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

tutorService.search = async ({ search, page, perPage }) => {
  let where = {};
  let whereUser = {};
  if (search) {
    whereUser = {
      [Op.or]: [
        {
          name: {
            [Op.iLike]: `%${search}%`,
          },
        },
      ],
    };
    where = {
      [Op.or]: [
        {
          education: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          bio: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          experience: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          profession: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          accent: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          targetStudent: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          interests: {
            [Op.like]: `%${search}%`,
          },
        },
        {
          resume: {
            [Op.like]: `%${search}%`,
          },
        },
      ],
    };
  }
  const tutors = await Tutor.findAndCountAll({
    where: {
      isActivated: true,
      ...where,
    },
    include: [
      {
        model: User,
        attributes: {
          exclude: ['id', 'password'],
        },
        include: [
          {
            model: TutorFeedback,
            as: 'feedbacks',
            include: [
              {
                model: User,
                as: 'firstInfo',
                attributes: {
                  exclude: ['id', 'password'],
                },
              },
            ],
          },
        ],
        // whereUser,
      },
    ],
    ...paginate({ page, perPage }),
  });
  const results = tutors.rows.map((tutor) => {
    const user = tutor.User;
    const result = { ...user.dataValues, ...tutor.dataValues };
    delete result.User;
    return result;
  });
  return { ...tutors, rows: results };
};

export default tutorService;
