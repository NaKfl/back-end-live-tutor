import ApiError from 'utils/ApiError';
import userService from './user.service';
import httpStatus from 'http-status';
import { ERROR_CODE } from 'utils/constants';

const authService = {};

authService.loginUserWithEmailAndPassword = async (email, password) => {
  const user = await userService.getUserByEmail(email);
  if (!user || !(await user.isPasswordMatch(password))) {
    throw new ApiError(
      ERROR_CODE.INCORRECT_EMAIL_PASSWORD.code,
      ERROR_CODE.INCORRECT_EMAIL_PASSWORD.message,
    );
  }
  if (!user.isActivated)
    throw new ApiError(
      ERROR_CODE.ACCOUNT_NOT_ACTIVATED.code,
      ERROR_CODE.ACCOUNT_NOT_ACTIVATED.message,
    );
  return user;
};

export default authService;
