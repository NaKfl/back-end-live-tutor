import catchAsync from 'utils/catchAsync';
import { tutorService, favoriteService } from 'services';

const tutorController = {};

tutorController.getMany = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.getMany(query);
  const favoriteTutor = await favoriteService.getListFavoriteTutorById(user.id);
  res.json({ tutors, favoriteTutor });
});

export default tutorController;
