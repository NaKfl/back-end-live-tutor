import { Role, User, UserRole } from 'database/models';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { Op } from 'sequelize';
import { v4 as uuidv4 } from 'uuid';
import { ROLES } from 'utils/constants';
import jwt from 'jsonwebtoken';
import { jwt as jwtVar } from 'configs/vars';
const userService = {};

userService.getUserByEmail = async (email) => {
  const user = await User.findOne({
    where: {
      email,
    },
    include: {
      model: Role,
    },
  });
  return user;
};

userService.getUserById = async (id) => {
  return await User.findOne({
    attributes: {
      exclude: ['password'],
    },
    where: {
      id,
    },
    include: {
      model: Role,
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

userService.createRole = async (userId, roleName) => {
  const roleId = await Role.findRoleIdByName(roleName);

  return await UserRole.create({
    userId,
    roleId,
  });
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

userService.oAuthLogin = async ({
  service,
  id,
  email = null,
  name,
  avatar,
}) => {
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
    include: {
      model: Role,
    },
  });
  if (user) {
    user[service] = id;
    if (!user.name) user.name = name;
    if (!user.avatar) user.avatar = avatar;
    return user.save();
  }
  const password = uuidv4();

  const newUser = await User.create({
    [service]: id,
    email,
    password,
    name,
    avatar,
  });

  await userService.createRole(newUser.id, ROLES.STUDENT);
  return await userService.getUserById(newUser.id);
};

userService.uploadAvatar = async ({ id, locationFile }) => {
  const user = await User.findOne({
    where: {
      id,
    },
  });
  user.update({ avatar: locationFile });
  return user;
};

userService.forgotPasswordRequest = async ({ email }) => {
  const user = await User.findOne({
    where: {
      email,
    },
  });
  if (!user) {
    throw Error("Email doesn't exist!");
  }
  const token = await jwt.sign(
    { id: user.id, email: user.email },
    jwtVar.secret,
  );
  return token;
};

userService.resetPassword = async (token, password) => {
  const { email, id } = await jwt.decode(token, jwtVar.secret);
  const user = await User.findOne({
    where: {
      id,
      email,
    },
  });
  await user.update({ password });
  return user;
};

export default userService;
