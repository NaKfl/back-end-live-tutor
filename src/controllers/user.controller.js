import catchAsync from 'utils/catchAsync';
import { userService } from 'services';

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

export default userController;
