import {
  Tutor,
  User,
  TutorFeedback,
  FavoriteTutor,
  sequelize,
} from 'database/models';
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

tutorService.getAllOnlineTutors = async () => {
  const allIdsExcludeMe = await onlineUsers.getAllIdsExcludeMe();
  const tutors = await Tutor.findAndCountAll({
    where: {
      isActivated: true,
    },
    include: [
      {
        model: User,
        where: {
          id: allIdsExcludeMe,
        },
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
    raw: true,
    nest: true,
  });
  const ratedTutors = tutors?.rows.map((item) => {
    const rating =
      item?.feedbacks?.reduce((acc, curr) => acc + curr.rating, 0) ?? 0;
    if (item?.feedbacks?.length > 0) {
      item.rating = +(rating / item.feedbacks.length).toFixed(1);
    }
    item.isOnline = true;
    return { ...item.User, ...item };
  });
  return ratedTutors;
};

tutorService.getOne = async (userId) => {
  const feedback = await TutorFeedback.findOne({
    separate: true,
    attributes: [[sequelize.fn('AVG', sequelize.col('rating')), 'avgRating']],
    where: {
      secondId: userId,
    },
  });
  const tutor = await Tutor.findOne({
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
  return { tutor, avgRating: feedback.dataValues.avgRating };
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
            [Op.iLike]: `%${search}%`,
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

tutorService.getListRankTutor = async (num) => {
  const numberOfTutor = num ? num : 5;
  const listTutorIds = await Tutor.findAll({
    where: sequelize.where(sequelize.col('User.feedbacks.rating'), {
      [Op.ne]: null,
    }),
    order: [
      [sequelize.fn('AVG', sequelize.col('User.feedbacks.rating')), 'DESC'],
    ],
    limit: numberOfTutor,
    include: [
      {
        model: User,
        attributes: [
          'name',
          'email',
          'avatar',
          'country',
          [
            sequelize.fn('AVG', sequelize.col('User.feedbacks.rating')),
            'avgRating',
          ],
        ],
        include: [
          {
            model: TutorFeedback,
            as: 'feedbacks',
            attributes: [],
            duplicating: false,
            required: false,
          },
        ],
      },
    ],
    group: [
      'Tutor.id',
      'User.name',
      'User.email',
      'User.avatar',
      'User.country',
    ],
    raw: true,
    nest: true,
  });

  return listTutorIds;
};

export default tutorService;
