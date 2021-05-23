import nodemailer from 'nodemailer';
import {
  nodemailer as nodemailerVars,
  googleCredential,
  jwt as jwtVar,
} from 'configs/vars';
import bookingConfirm from './templates/bookingConfirm';
import activateAccount from './templates/activateAccount';
import { forgotPassword } from './templates/forgotPassword';
import jwt from 'jsonwebtoken';

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

export const confirmBookingNewSchedule = async ({ origin, ...bookingInfo }) => {
  try {
    const userInfo = {
      displayName: bookingInfo?.student?.name,
      email: bookingInfo?.student?.email,
    };
    const listDates = bookingInfo.dates.map((date) => {
      const day = date[0].date;
      const startPeriod = date[0].start;
      const endPeriod = date[date.length - 1].end;
      const token = jwt.sign(
        {
          participantId: bookingInfo?.tutor?.id,
          roomName: bookingInfo?.roomName,
          userInfo,
          userCall: bookingInfo?.student,
          userBeCalled: bookingInfo?.tutor,
          isTutor: bookingConfirm?.isSendTutor,
          startTime: bookingInfo?.startTime,
        },
        jwtVar.secret,
      );
      const link = `${origin}/call/?token=${token}`;
      return {
        date: day,
        start: startPeriod,
        end: endPeriod,
        link,
      };
    });
    bookingInfo.listDates = listDates;
    await transporter.sendMail({
      from: `"Live tutor" peterpans2030@gmail.com`,
      to: bookingInfo?.isSendTutor
        ? bookingInfo?.tutor?.email
        : bookingInfo?.student?.email,
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

export const sendMailActivateAccount = async (user, verifyLink) => {
  try {
    await transporter.sendMail({
      from: `"Live tutor" peterpans2030@gmail.com`,
      to: user?.email,
      subject: 'Verify your email address',
      html: activateAccount(verifyLink),
    });
  } catch (error) {
    console.log('Error: ', error);
  }
};
