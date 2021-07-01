import {
  Role,
  User,
  UserRole,
  Tutor,
  Wallet,
  TutorFeedback,
  sequelize,
} from 'database/models';
import ApiError from 'utils/ApiError';
import { Op } from 'sequelize';
import { v4 as uuidv4 } from 'uuid';
import { ROLES, ERROR_CODE } from 'utils/constants';
import jwt from 'jsonwebtoken';
import { jwt as jwtVar } from 'configs/vars';
import { sendMailActivateAccount } from 'configs/nodemailer';
import { paymentService } from 'services';
import { paginate } from 'utils/sequelize';

const userService = {};

userService.getUserByEmail = async (email) => {
  const user = await User.findOne({
    where: {
      email,
    },
    include: [
      {
        model: Role,
      },
      {
        model: Wallet,
        as: 'walletInfo',
      },
    ],
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
    include: [
      {
        model: Role,
      },
      {
        model: Wallet,
        as: 'walletInfo',
      },
    ],
  });
};

userService.getInfoById = async (id) => {
  const feedback = await TutorFeedback.findOne({
    separate: true,
    attributes: [[sequelize.fn('AVG', sequelize.col('rating')), 'avgRating']],
    where: {
      secondId: id,
    },
  });

  const userInfo = await User.findOne({
    attributes: {
      exclude: ['password'],
    },
    where: {
      id,
    },
    include: [
      { model: Role },
      { model: Wallet, as: 'walletInfo' },
      { model: Tutor, as: 'tutorInfo' },
      {
        model: TutorFeedback,
        as: 'feedbacks',
        include: [
          {
            model: User,
            as: 'firstInfo',
            attributes: {
              exclude: ['password'],
            },
          },
          {
            model: User,
            as: 'secondInfo',
            attributes: {
              exclude: ['password'],
            },
          },
        ],
      },
    ],
  });
  return {
    userInfo,
    avgRating: feedback.dataValues.avgRating,
  };
};

userService.updateUserById = async (fields, id) => {
  return await User.update(fields, {
    where: {
      id,
    },
  });
};

userService.createUser = async (userBody, origin) => {
  if (await User.isEmailTaken(userBody.email)) {
    throw new ApiError(
      ERROR_CODE.EMAIL_EXIST.code,
      ERROR_CODE.EMAIL_EXIST.message,
    );
  }
  const name = (userBody?.email.split('@'))[0];
  const userCreated = {
    ...userBody,
    name,
  };
  const user = await User.create(userCreated);

  // Create role
  const roleId = await Role.findRoleIdByName(ROLES.STUDENT);
  await UserRole.create({ userId: user.id, roleId });

  // Create wallet
  await paymentService.createWallet(user.id);

  await userService.sendMailToActiveAccount(user, origin);
  return user;
};

userService.sendMailToActiveAccount = async (user, origin) => {
  // Mailing
  const token = await jwt.sign(
    { id: user.id, email: user.email },
    jwtVar.secret,
  );
  const verifyLink = `${origin}/verifyAccount?token=${token}`;
  sendMailActivateAccount(user, verifyLink);
  return true;
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
    await user.save();
    return await userService.getUserById(user.id);
  }
  const password = uuidv4();

  const newUser = await User.create({
    [service]: id,
    isActivated: true,
    email,
    password,
    name,
    avatar,
  });

  // Create role
  await userService.createRole(newUser.id, ROLES.STUDENT);

  // Create wallet
  await paymentService.createWallet(newUser.id);

  return await userService.getUserById(newUser.id);
};

userService.uploadAvatar = async ({ id, locationFile }) => {
  const user = await User.findOne({
    where: {
      id,
    },
  });
  return await user.update({ avatar: locationFile });
};

userService.forgotPasswordRequest = async ({ email }) => {
  const user = await User.findOne({
    where: {
      email,
    },
  });
  if (!user) {
    throw new ApiError(
      ERROR_CODE.EMAIL_NOT_EXIST.code,
      ERROR_CODE.EMAIL_NOT_EXIST.message,
    );
  }
  const token = await jwt.sign(
    { id: user.id, email: user.email },
    jwtVar.secret,
  );
  await user.update({ requestPassword: true });
  return token;
};

userService.verifyAccount = async (token) => {
  const user = jwt.verify(token, jwtVar.secret);
  const { id } = user;
  const result = await User.update(
    { isActivated: true },
    {
      where: {
        id,
      },
    },
  );

  return result;
};

userService.resetPassword = async (token, password) => {
  const { email, id } = await jwt.decode(token, jwtVar.secret);
  const user = await User.findOne({
    where: {
      id,
      email,
    },
  });
  if (user.requestPassword === false)
    throw new ApiError(
      ERROR_CODE.USER_NOT_REQUEST_CHANGEPW.code,
      ERROR_CODE.USER_NOT_REQUEST_CHANGEPW.message,
    );
  return await user.update({ password, requestPassword: false });
};

userService.getAll = async ({ page = 1, perPage = 15 }) => {
  return await User.findAndCountAll({
    include: [
      {
        model: Role,
        attributes: ['name'],
      },
      {
        model: Wallet,
        as: 'walletInfo',
        attributes: ['amount'],
      },
    ],
    ...paginate({ page, perPage }),
    order: [['createdAt', 'DESC']],
  });
};

userService.manageActivated = async ({ id, isActivated }) => {
  const a = await User.update({ isActivated: !isActivated }, { where: { id } });
  return a;
};

export default userService;
