import catchAsync from 'utils/catchAsync';
import {
  userService,
  favoriteService,
  feedbackService,
  callService,
} from 'services';
import moment from 'moment';
import { sendForgotPasswordEmail } from 'configs/nodemailer';

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
    'http://' + req.headers.host + `/${file.fieldname}/` + file.filename;
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

userController.endCall = catchAsync(async (req, res) => {
  const field = req.body;
  field.startTime = new Date(field.startTime);
  field.endTime = moment(field.endTime).toISOString();
  console.log(field);
  const result = await callService.add(field);
  res.send(result);
});

userController.getCallSessionHistory = catchAsync(async (req, res) => {
  const { user, query } = req;
  const result = await callService.getSessionByStudentId({
    id: user?.id,
    ...query,
  });
  res.send(result);
});

userController.forgotPassword = catchAsync(async (req, res) => {
  const { email } = req.body;
  const token = await userService.forgotPasswordRequest({ email });
  const origin = req.headers?.origin || 'http://localhost:3000';
  const linkToken = `${origin}/resetpassword?token=${token}`;
  await sendForgotPasswordEmail({ receiver: email, link: linkToken });
  res.send({ message: 'Email send success!' });
});

userController.ressetPassword = catchAsync(async (req, res) => {
  const { token, password } = req.body;
  const user = await userService.resetPassword(token, password);
  res.send(user);
});

export default userController;
