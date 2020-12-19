import passport from 'passport';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';
import { userService } from 'services';

const verifyCallback = (req, resolve, reject, requiredRoles) => async (
  err,
  user,
  info,
) => {
  if (err || info || !user) {
    return reject(new ApiError(httpStatus.UNAUTHORIZED, 'Please authenticate'));
  }

  req.user = user;

  if (requiredRoles.length) {
    const userRoles = await userService.getRolesFromId(user.id);
    const isAuthorized = requiredRoles.some((requiredRole) => {
      return userRoles.includes(requiredRole);
    });
    if (!isAuthorized && req.params.userId !== user.id) {
      return reject(new ApiError(httpStatus.FORBIDDEN, 'Forbidden'));
    }
  }

  resolve();
};

const auth = (...requiredRoles) => async (req, res, next) => {
  return new Promise((resolve, reject) => {
    passport.authenticate(
      'jwt',
      { session: false },
      verifyCallback(req, resolve, reject, requiredRoles),
    )(req, res, next);
  })
    .then(() => next())
    .catch((err) => next(err));
};

export default auth;
