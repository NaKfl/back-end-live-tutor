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
import acceptedTutor from './templates/acceptedTutor';
import logger from 'configs/logger';
import moment from 'moment';
import { bookingService } from 'services';

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
    const user = {
      name: bookingInfo?.isSendTutor
        ? bookingInfo.tutor.name
        : bookingInfo.student.name,
      email: bookingInfo?.isSendTutor
        ? bookingInfo.tutor.email
        : bookingInfo.student.email,
    };
    const listDates = bookingInfo.dates.map((date) => {
      const bookingIds = date.map((item) => item.bookingId);
      const day = date[0].date;
      const startPeriod = date[0].start;
      const endPeriod = date[date.length - 1].end;
      const startTime = moment(`${day} ${startPeriod}`);
      const obj = {
        context: {
          user: {
            email: user?.email,
            name: user?.name,
          },
        },
        room: bookingInfo?.roomName,
        roomName: bookingInfo?.roomName,
        userCall: bookingInfo?.student,
        userBeCalled: bookingInfo?.tutor,
        isTutor: bookingInfo?.isSendTutor,
        startTime,
      };
      const token = jwt.sign(obj, jwtVar.secret, {
        issuer: 'livetutor',
        subject: 'https://meet.livetutor.live',
        expiresIn: '2h',
        audience: 'livetutor',
      });
      const linkWithoutOrigin = `/call/?token=${token}`;
      const link = `${origin}/call/?token=${token}`;
      bookingService.updateLink(
        bookingIds,
        bookingInfo?.isSendTutor,
        linkWithoutOrigin,
      );
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
    logger.error(error);
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
    logger.error(error);
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
    logger.error(error);
  }
};

export const sendMailAcceptedTutor = async (user, isActivated) => {
  try {
    await transporter.sendMail({
      from: `"Live tutor" peterpans2030@gmail.com`,
      to: user?.email,
      subject: 'Verify your email address',
      html: acceptedTutor(isActivated),
    });
  } catch (error) {
    logger.error(error);
  }
};
