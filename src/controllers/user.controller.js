import catchAsync from 'utils/catchAsync';
import { userService, favoriteService } from 'services';

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

export default userController;
