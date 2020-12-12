import ApiError from 'utils/ApiError';
import httpStatus from 'http-status';
import { v4 as uuidv4 } from 'uuid';
import { student as Student } from 'database/models';

const studentService = {};

studentService.getUserByEmail = async (email) => {
  return await Student.findOne({
    where: {
      email,
    },
  });
};

studentService.createUser = async (userBody) => {
  if (await Student.isEmailTaken(userBody.email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, 'Email already taken');
  }
  const user = await Student.create({ id: uuidv4(), ...userBody });
  return user;
};

export default studentService;
