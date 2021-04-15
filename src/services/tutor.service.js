import { Tutor, User, TutorFeedback, FavoriteTutor } from 'database/models';
import { paginate, searchHelp, SetById } from 'utils/sequelize';
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
  let where = {
    isActivated: true,
  };
  if (search) {
    where = {
      isActivated: true,
      [Op.or]: searchHelp({ Op, keys: null, searchKey: search }),
    };
  }
  const tutors = await Tutor.findAndCountAll({
    where,
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
    ...paginate({ page, perPage }),
  });
  const tutorsByName = await Tutor.findAndCountAll({
    where: {
      isActivated: true,
    },
    include: [
      {
        model: User,
        attributes: {
          exclude: ['id', 'password'],
        },
        where: {
          name: {
            [Op.like]: `%${search}%`,
          },
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
    ...paginate({ page, perPage }),
  });

  const matchTutor = SetById([...tutors.rows, ...tutorsByName.rows]);

  const promises = matchTutor.map(async (tutor) => {
    const user = tutor.User;
    const groupUser = { ...user.dataValues, ...tutor.dataValues };
    groupUser.isOnline = await onlineUsers.isUserOnline(tutor.userId);
    delete groupUser.User;
    return groupUser;
  });

  const result = await Promise.all(promises);

  return { count: tutorsByName.count + tutors.count, rows: result };
};

export default tutorService;
