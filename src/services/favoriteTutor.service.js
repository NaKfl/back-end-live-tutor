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
    return await FavoriteTutor.create({
      firstId,
      secondId,
    });
  }
};

favoriteService.getListFavoriteTutorById = async (id) => {
  const listFavoriteTutorId = await FavoriteTutor.findAll({
    where: {
      firstId: id,
    },
    order: [['createdAt', 'DESC']],
  });

  const listTutor = await Promise.all(
    listFavoriteTutorId.map(async (rawData) => {
      const { secondId } = rawData.toJSON();
      const rawTutor = await Tutor.findOne({
        where: { id: secondId },
        include: [
          {
            model: User,
            as: 'User',
            attributes: {
              exclude: ['id', 'password'],
            },
          },
        ],
      });

      return rawTutor.toJSON();
    }),
  );
  return listTutor;
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
