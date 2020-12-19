import ApiError from 'utils/ApiError';
import httpStatus from 'http-status';
import { User } from 'database/models';

const userService = {};

userService.getUserByEmail = async (email) => {
  return await User.findOne({
    where: {
      email,
    },
  });
};

userService.createUser = async (userBody) => {
  if (await User.isEmailTaken(userBody.email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, 'Email already taken');
  }
  // TODO: Thêm role mặc định là student
  const user = await User.create(userBody);
  return user;
};

export default userService;
