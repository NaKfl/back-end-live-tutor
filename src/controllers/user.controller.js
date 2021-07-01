import catchAsync from 'utils/catchAsync';
import {
  userService,
  favoriteService,
  feedbackService,
  callService,
} from 'services';
import moment from 'moment';
import { sendForgotPasswordEmail } from 'configs/nodemailer';
import { stringDate } from 'utils/common';

const userController = {};

userController.getInfo = catchAsync(async (req, res) => {
  const { id } = req.user;
  const { userId } = req.params;
  let idUser = id;
  if (userId) {
    idUser = userId;
  }
  const { userInfo, avgRating } = await userService.getInfoById(idUser);
  const user = {
    ...userInfo.transform(),
    avgRating: avgRating ?? 0,
  };
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
  const url = req.headers?.origin + `/${file.fieldname}/` + file.filename;
  const result = await userService.uploadAvatar({
    id: req.user.id,
    locationFile: url,
  });
  res.send(result);
});

userController.feedbackTutor = catchAsync(async (req, res) => {
  const { user, body } = req;
  const { sessionId, userId, rating, content, isTutor } = body;
  const data = await feedbackService.feedbackTutor({
    sessionId,
    firstId: user.id,
    secondId: userId,
    rating,
    content,
    isTutor,
  });
  res.json({ message: 'Feedback success', data });
});

userController.endCall = catchAsync(async (req, res) => {
  const field = req.body;
  field.startTime = new Date(field.startTime);
  field.endTime = moment(field.endTime).toISOString();
  const result = await callService.add(field);
  res.send(result);
});

userController.getCallSessionHistory = catchAsync(async (req, res) => {
  const { user, query } = req;
  const result = await callService.getSessionByStudentId({
    id: user?.id,
    ...query,
  });
  const listSessions = result.rows.map((row) => {
    const callSession = row.toJSON();
    const start = moment(callSession.startTime);
    const end = moment(callSession.endTime);
    const ms = end.diff(start) > 0 ? end.diff(start) : start.diff(end);

    return {
      ...callSession,
      during: stringDate(ms),
    };
  });
  result.rows = listSessions;
  res.send(result);
});

userController.forgotPassword = catchAsync(async (req, res) => {
  const { email } = req.body;
  const token = await userService.forgotPasswordRequest({ email });
  const origin = req.headers?.origin || 'http://localhost:3000';
  const linkToken = `${origin}/password?token=${token}`;
  await sendForgotPasswordEmail({ receiver: email, link: linkToken });
  res.send({ message: 'Email send success!' });
});

userController.resetPassword = catchAsync(async (req, res) => {
  const { token, password } = req.body;
  const user = await userService.resetPassword(token, password);
  res.send(user);
});

userController.getAll = catchAsync(async (req, res) => {
  const { query } = req;
  const { page, perPage } = query;
  const result = await userService.getAll({ page, perPage });
  res.send(result);
});

userController.manageActivated = catchAsync(async (req, res) => {
  const { id, isActivated } = req.body;
  const result = await userService.manageActivated({ id, isActivated });
  res.send(result);
});

userController.getAllFeedbacks = catchAsync(async (req, res) => {
  const { user } = req;
  let data = {};
  const { userInfo, avgRating } = await feedbackService.getAllFeedbacks(
    user.id,
  );
  if (user) {
    data = userInfo.toJSON();
    data.avgRating = avgRating ? avgRating : 0;
  }
  res.json({ message: 'Success', data });
});

userController.getSessionFeedback = catchAsync(async (req, res) => {
  const { user } = req;
  const { id: sessionId } = req.params;
  const feedbacks = await feedbackService.getSessionFeedback(
    sessionId,
    user.id,
  );

  res.json({
    message: 'Success',
    data: feedbacks,
  });
});
export default userController;
