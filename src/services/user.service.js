import { Role, User, UserRole } from 'database/models';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { Op } from 'sequelize';
import { v4 as uuidv4 } from 'uuid';
import { ROLES } from 'utils/constants';

const userService = {};

userService.getUserByEmail = async (email) => {
  return await User.findOne({
    where: {
      email,
    },
  });
};

userService.getUserById = async (id) => {
  return await User.findOne({
    attributes: {
      exclude: ['password'],
    },
    where: {
      id,
    },
  });
};

userService.updateUserById = async (fields, id) => {
  return await User.update(fields, {
    where: {
      id,
    },
  });
};

userService.createUser = async (userBody) => {
  if (await User.isEmailTaken(userBody.email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, 'Email already taken');
  }
  const user = await User.create(userBody);
  const roleId = await Role.findRoleIdByName(ROLES.STUDENT);
  await UserRole.create({ userId: user.id, roleId });
  return user;
};

userService.getRolesFromId = async (id) => {
  const user = await User.findOne({
    include: {
      model: Role,
    },
    where: {
      id,
    },
  });
  const roles = user.Roles.map((role) => role.name);
  return roles;
};

userService.oAuthLogin = async ({ service, id, email, name, avatar }) => {
  const user = await User.findOne({
    attributes: {
      exclude: ['password'],
    },
    where: {
      [Op.or]: {
        email,
        [Op.or]: {
          facebook: id,
          google: id,
        },
      },
    },
  });
  if (user) {
    user[service] = id;
    if (!user.name) user.name = name;
    if (!user.avatar) user.avatar = avatar;
    return user.save();
  }
  const password = uuidv4();
  return User.create({
    [service]: id,
    email,
    password,
    name,
    avatar,
  });
};

userService.uploadAvatar = async ({ id, locationFile }) => {
  const res = await User.update(
    { avatar: locationFile },
    {
      where: {
        id,
      },
    },
  );
  return res;
};
export default userService;
