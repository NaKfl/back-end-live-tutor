import { FavoriteTutor, User, Tutor } from 'database/models';
const favoriteService = {};

favoriteService.manageFavoriteTutor = async ({ firstId, secondId }) => {
  const exist = await FavoriteTutor.findOne({
    where: {
      firstId,
      secondId,
    },
  });
  if (exist !== null) {
    return await FavoriteTutor.destroy({
      where: {
        firstId,
        secondId,
      },
    });
  } else {
    await FavoriteTutor.create({
      firstId,
      secondId,
    });
    return await FavoriteTutor.findOne({
      where: {
        firstId,
        secondId,
      },
      include: [
        {
          model: User,
          as: 'secondInfo',
          attributes: {
            exclude: ['password'],
          },
          include: [
            {
              model: Tutor,
              as: 'tutorInfo',
            },
          ],
        },
      ],
      order: [['createdAt', 'DESC']],
    });
  }
};

favoriteService.getListFavoriteTutorById = async (id) => {
  return await FavoriteTutor.findAll({
    where: {
      firstId: id,
    },
    include: [
      {
        model: User,
        as: 'secondInfo',
        attributes: {
          exclude: ['password'],
        },
        include: [
          {
            model: Tutor,
            as: 'tutorInfo',
          },
        ],
      },
    ],
    order: [['createdAt', 'DESC']],
  });
};

favoriteService.getListFavoriteTutorOnlySecondId = async (id) => {
  return await FavoriteTutor.findAll({
    where: {
      firstId: id,
    },
    attributes: ['id', 'secondId'],
  });
};
export default favoriteService;
