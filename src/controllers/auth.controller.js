import httpStatus from 'http-status';
import catchAsync from 'utils/catchAsync';
import {
  userService,
  tokenService,
  authService,
  refreshTokenService,
} from 'services';
import moment from 'moment';
import { ERROR_CODE } from 'utils/constants';
import ApiError from 'utils/ApiError';
const authController = {};

authController.register = catchAsync(async (req, res) => {
  const origin = req.headers?.origin || 'http://localhost:3000';
  const user = await userService.createUser(req.body, origin);
  const tokens = await tokenService.generateAuthTokens(user);
  res.status(httpStatus.CREATED).json({ user: user.transform(), tokens });
});

authController.sendMailActivateAccount = catchAsync(async (req, res) => {
  const origin = req.headers?.origin || 'http://localhost:3000';
  const { user } = req;
  await userService.sendMailToActiveAccount(user, origin);
  res.json({ message: 'Send an activate email successfully' });
});

authController.login = catchAsync(async (req, res) => {
  const { email, password } = req.body;
  const user = await authService.loginUserWithEmailAndPassword(email, password);
  const tokens = await tokenService.generateAuthTokens(user);
  res.json({ user: user.transform(), tokens });
});

authController.oAuth = catchAsync(async (req, res) => {
  const { user } = req;
  const tokens = await tokenService.generateAuthTokens(user);
  res.json({ user: user.transform(), tokens });
});

authController.verifyAccount = catchAsync(async (req, res) => {
  const { query } = req;
  const { token } = query;
  await userService.verifyAccount(token);
  res.json({ message: 'Active account successfully' });
});

authController.refresh = catchAsync(async (req, res) => {
  const { email, refreshToken } = req.body;
  const existedRefreshToken = await refreshTokenService.getOneAndDestroy(
    email,
    refreshToken,
  );
  if (
    !existedRefreshToken ||
    moment(existedRefreshToken.expires).isBefore(moment())
  ) {
    throw new ApiError(
      ERROR_CODE.INVALID_REFRESH_TOKEN.code,
      ERROR_CODE.INVALID_REFRESH_TOKEN.message,
    );
  }
  const user = await userService.getUserByEmail(email);
  const tokens = await tokenService.generateAuthTokens(user);
  res.json({ user: user.transform(), tokens });
});

export default authController;
