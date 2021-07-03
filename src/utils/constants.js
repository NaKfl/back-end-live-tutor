export const TOKEN_TYPES = {
  ACCESS: 'access',
  REFRESH: 'refresh',
};

export const ROLES = {
  STUDENT: 'student',
  ADMIN: 'admin',
  TUTOR: 'tutor',
};

export const MINUTES_PER_SESSION = 30;

export const PRICE_PER_SESSION_KEY = 'pricePerSession';
export const PRICE_PER_DOLLAR = 'pricePerDollar';

export const TRANSACTION_TYPES = {
  BUY: 'buy',
  SELL: 'sell',
  DEPOSIT: 'deposit',
  CANCEL: 'cancel',
  RETURN: 'return',
};

export const DEFAULT_PRICE_PER_DOLLAR = 23500;

export const TIME_FORMAT = 'HH:mm';

export const DATE_TIME_FORMAT = 'YYYY-MM-DD HH:mm';

export const TIME_IN_ROOM = 30 * 60; // 30 phut

export const DATE_TIME_FORMAT_YY_MM_DD_HH_MM_SS = 'YY-MM-DD HH:mm:ss';

export const ERROR_CODE = {
  INVALID_TOKEN_TYPE: {
    code: 0,
    message: 'Invalid token type',
  },
  PLEASE_AUTHENTICATE: {
    code: 1,
    message: 'Please authenticate',
  },
  ACCOUNT_NOT_ACTIVATED: {
    code: 2,
    message: 'Your account has not activated',
  },
  PERMISSION_DENIED: {
    code: 3,
    message: 'Permission denied',
  },
  EMAIL_EXIST: {
    code: 4,
    message: 'Email has already taken',
  },
  EMAIL_NOT_EXIST: {
    code: 5,
    message: "Email doesn't exist!",
  },
  USER_NOT_REQUEST_CHANGEPW: {
    code: 6,
    message: 'User does not request to change password',
  },
  INCORRECT_EMAIL_PASSWORD: {
    code: 7,
    message: 'Incorrect email or password',
  },
  HAVE_BEEN_TUTOR: {
    code: 8,
    message: 'User has already been a tutor',
  },
  FILE_TYPE_NOT_SUPPORT: {
    code: 9,
    message: 'File type does not support in situation',
  },
  BOOKING_CANCEL_BEFORE_1DAY: {
    code: 10,
    message: 'You can only cancel booking before 1 day',
  },
  BOOKING_EXIST: {
    code: 11,
    message: 'Booking has already exists',
  },
  BOOKING_NOT_EXIST: {
    code: 12,
    message: 'Booking does not exist',
  },
  PAYMENT_SYSTEM: {
    code: 13,
    message: 'Payment system has problems',
  },
  WALLET_BLOCKED: {
    code: 14,
    message: 'Your wallet is blocked',
  },
  NOT_ENOUGH_MONEY: {
    code: 15,
    message: 'Not enough money',
  },
  SELLER_NOT_ENOUGH: {
    code: 16,
    message: 'Seller amount not enough',
  },
  END_GREATER_START: {
    code: 17,
    message: 'End time should be greater than start time',
  },
  PERIOD_DIVISIABLE_30: {
    code: 18,
    message: 'The period must be divisible by 30',
  },
  SCHEDULE_DUPLICATE: {
    code: 19,
    message: 'Conflict to register schedule',
  },
  SCHEDULE_INVALID_DATE: {
    code: 20,
    message: 'Register schedule with invalid date',
  },
  INVALID_REFRESH_TOKEN: {
    code: 21,
    message: 'Invalid refresh token',
  },
  INVALID_TOKEN: {
    code: 22,
    message: 'Invalid token',
  },
  DEPOSIT_REJECTED: {
    code: 23,
    message: 'Deposit was rejected',
  },
  FILE_SIZE_OVER_LIMIT_AVATAR: {
    code: 24,
    message: 'Avatar file size is over limit',
  },
  FILE_SIZE_OVER_LIMIT_VIDEO: {
    code: 25,
    message: 'Video size is over limit',
  },
};

export const MAX_AVATAR_SIZE = 10 * 1024 * 1024;

export const MAX_VIDEO_SIZE = 100 * 1024 * 1024;
