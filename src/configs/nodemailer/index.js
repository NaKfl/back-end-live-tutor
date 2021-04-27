import nodemailer from 'nodemailer';
import { nodemailer as nodemailerVars, googleCredential } from 'configs/vars';
import bookingConfirm from './templates/bookingConfirm';
import { forgotPassword } from './templates/forgotPassword';

const transporter = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 465,
  secure: true,
  auth: {
    type: 'OAuth2',
    user: nodemailerVars.email,
    clientId: googleCredential.clientId,
    clientSecret: googleCredential.clientSecret,
    refreshToken: googleCredential.refreshToken,
  },
});

export const confirmBookingNewSchedule = async (bookingInfo) => {
  try {
    await transporter.sendMail({
      from: `"Live tutor" peterpans2030@gmail.com`,
      to: bookingInfo?.receiver,
      subject: 'You already have register new schedule successfully',
      html: bookingConfirm(bookingInfo),
    });
  } catch (error) {
    console.log('Error: ', error);
  }
};

export const sendForgotPasswordEmail = async ({ receiver, link }) => {
  try {
    await transporter.sendMail({
      from: `"Live tutor" peterpans2030@gmail.com`,
      subject: 'Reset your password email',
      to: receiver,
      html: forgotPassword(link),
    });
  } catch (error) {
    console.log('Error: ', error);
  }
};
