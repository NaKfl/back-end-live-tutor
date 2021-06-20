import { Op } from 'sequelize';
import { RefreshToken } from 'database/models';

const RefreshTokenService = {};

RefreshTokenService.createOne = async (user, token, expires) => {
  const userId = user.id;
  const userEmail = user.email;
  return await RefreshToken.create({
    token,
    userId,
    userEmail,
    expires,
  });
};

RefreshTokenService.getOneAndDestroy = async (userEmail, token) => {
  const existedToken = await RefreshToken.findOne({
    where: {
      [Op.and]: [{ userEmail }, { token }],
    },
  });
  if (existedToken)
    RefreshToken.destroy({
      where: {
        id: existedToken.id,
      },
    });
  return existedToken;
};

export default RefreshTokenService;
