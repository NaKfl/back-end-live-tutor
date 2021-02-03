import { FavoriteTutor, User } from 'database/models';
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
        as: 'firstInfo',
      },
      {
        model: User,
        as: 'secondInfo',
      },
    ],
    // attributes: [],
  });
};

export default favoriteService;
