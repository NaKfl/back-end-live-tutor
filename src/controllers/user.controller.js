import catchAsync from 'utils/catchAsync';
import { userService, favoriteService, feedbackService } from 'services';

const userController = {};

userController.getInfo = catchAsync(async (req, res) => {
  const { id } = req.user;
  const user = await userService.getUserById(id);
  res.json({ user });
});

userController.updateInfo = catchAsync(async (req, res) => {
  const { body, user } = req;
  await userService.updateUserById(body, user.id);
  const userInfo = await userService.getUserById(user.id);
  res.json({ user: userInfo });
});

userController.getAllFavoriteTutor = catchAsync(async (req, res) => {
  const { user } = req;
  const list = await favoriteService.getListFavoriteTutorById(user.id);
  res.send(list);
});

userController.manageFavoriteTutor = catchAsync(async (req, res) => {
  const { user, body } = req;
  const { tutorId } = body;
  const result = await favoriteService.manageFavoriteTutor({
    firstId: user.id,
    secondId: tutorId,
  });
  res.json({ message: 'Manage success', result });
});

userController.updateAvatar = catchAsync(async (req, res) => {
  const file = req.file;
  const url =
    'http://' + req.headers.host + `/${req.file.fieldname}/` + file.filename;
  const result = await userService.uploadAvatar({
    id: req.user.id,
    locationFile: url,
  });
  res.send(result);
});

userController.feedbackTutor = catchAsync(async (req, res) => {
  const { user, body } = req;
  const { tutorId, rating, content } = body;
  const data = await feedbackService.feedbackTutor({
    firstId: user.id,
    secondId: tutorId,
    rating,
    content,
  });
  res.json({ message: 'Feedback success', data });
});

export default userController;
