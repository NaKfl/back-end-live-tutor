import catchAsync from 'utils/catchAsync';
import { tutorService, favoriteService, userService } from 'services';

const tutorController = {};

tutorController.getMany = catchAsync(async (req, res) => {
  const { query, user } = req;
  const tutors = await tutorService.getMany(query);
  const favoriteTutor = await favoriteService.getListFavoriteTutorById(user.id);
  res.json({ tutors, favoriteTutor });
});

tutorController.register = catchAsync(async (req, res) => {
  const file = req.files;
  console.log(file);
  // const url =
  //   'http://' + req.headers.host + `/${req.files.fieldname}/` + file.filename;
  // const result = await userService.uploadAvatar({
  //   id: req.user.id,
  //   locationFile: url,
  // });
  res.send('result');
});

export default tutorController;
