import ApiError from 'utils/ApiError';
import studentService from './student.service';
import httpStatus from 'http-status';

const authService = {};

authService.loginUserWithEmailAndPassword = async (email, password) => {
  const user = await studentService.getUserByEmail(email);
  if (!user || !(await user.isPasswordMatch(password))) {
    throw new ApiError(httpStatus.UNAUTHORIZED, 'Incorrect email or password');
  }
  return user;
};

export default authService;
