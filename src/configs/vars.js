import dotenv from 'dotenv';
dotenv.config();

export const env = process.env.NODE_ENV;
export const port = process.env.PORT;
export const logs = process.env.NODE_ENV === 'production' ? 'combined' : 'dev';
export const CLIENT_URL = process.env.CLIENT_URL;
export const SERVER_URL = process.env.SERVER_URL;
export const ADMIN_URL = process.env.ADMIN_URL;
export const jwt = {
  secret: process.env.JWT_SECRET,
  accessExpirationMinutes: process.env.JWT_EXPIRATION_MINUTES,
  refreshTokenExpirationDays: process.env.JWT_REFRESH_EXPIRATION_DAYS,
};
export const redis = {
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT,
};
export const nodemailer = {
  email: process.env.NODE_MAILER_EMAIL,
  password: process.env.NODE_MAILER_PASSWORD,
};
export const googleCredential = {
  clientId: process.env.GOOGLE_CLIENT_ID,
  clientSecret: process.env.GOOGLE_CLIENT_SECRET,
  refreshToken: process.env.GOOGLE_REFRESH_TOKEN,
  accessToken: process.env.GOOGLE_ACCESS_TOKEN,
  firebase: process.env.FIREBASE_CREDENTIALS,
};
