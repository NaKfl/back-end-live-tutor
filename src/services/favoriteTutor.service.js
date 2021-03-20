import { FavoriteTutor, User, Tutor } from 'database/models';
const favoriteService = {};

favoriteService.manageFavoriteTutor = async ({ firstId, secondId }) => {
  const exist = await FavoriteTutor.findOne({
    where: {
      firstId,
      secondId,
    },
    attributes: { exclude: ['userId'] },
  });
  if (exist !== null) {
    return await FavoriteTutor.destroy({
      where: {
        firstId,
        secondId,
      },
    });
  } else {
    return await FavoriteTutor.create({
      firstId,
      secondId,
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
      },
      {
        model: Tutor,
        as: 'tutorInfo',
      },
    ],
    attributes: [],
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
