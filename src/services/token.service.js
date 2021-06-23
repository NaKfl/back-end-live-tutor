import jwt from 'jsonwebtoken';
import moment from 'moment';
import { jwt as jwtVars } from 'configs/vars';
import { TOKEN_TYPES } from 'utils/constants';
import { refreshTokenService } from 'services';

const tokenService = {};

const generateToken = (userId, expires, type, secret = jwtVars.secret) => {
  const payload = {
    sub: userId,
    iat: moment().unix(),
    exp: expires.unix(),
    type,
  };
  return jwt.sign(payload, secret);
};

tokenService.generateAuthTokens = async (user) => {
  const accessTokenExpires = moment().add(
    jwtVars.accessExpirationMinutes,
    'minutes',
  );
  const refreshTokenTokenExpires = moment().add(
    jwtVars.refreshTokenExpirationDays,
    'days',
  );
  const accessToken = generateToken(
    user.id,
    accessTokenExpires,
    TOKEN_TYPES.ACCESS,
  );
  const refreshToken = generateToken(
    user.id,
    refreshTokenTokenExpires,
    TOKEN_TYPES.REFRESH,
  );

  await refreshTokenService.createOne(
    user,
    refreshToken,
    refreshTokenTokenExpires.toDate(),
  );

  return {
    access: {
      token: accessToken,
      expires: accessTokenExpires.toDate(),
    },
    refresh: {
      token: refreshToken,
      expires: refreshTokenTokenExpires.toDate(),
    },
  };
};

export default tokenService;
