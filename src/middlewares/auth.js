import passport from 'passport';
import httpStatus from 'http-status';
import ApiError from 'utils/ApiError';

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
    // TODO: Query để lấy roles của user
    // const userRoles=...
    const isAuthorized = requiredRoles.every((requiredRole) => {
      // TODO: Nếu mà thỏa hết thì isAuthorized = true
      // return userRoles.includes(requiredRole),
      return true;
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
