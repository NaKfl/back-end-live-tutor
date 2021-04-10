import { sequelize, CallSession, User } from 'database/models';
import { query } from 'express';
import { paginate } from 'utils/sequelize';

const callSessionService = {};

callSessionService.add = async ({ studentId, tutorId, startTime, endTime }) => {
  const session = await sequelize.transaction(async (t) => {
    const existedSession = await CallSession.findOne({
      where: {
        studentId,
        tutorId,
        startTime,
      },
      transaction: t,
    });
    if (existedSession) {
      return existedSession;
    } else {
      return await CallSession.create(
        { studentId, tutorId, startTime, endTime },
        { lock: true, transaction: t },
      );
    }
  });
  return session;
};

callSessionService.getSessionByStudentId = async ({
  id,
  page = 1,
  perPage = 10,
  isTutor = false,
}) => {
  let query = {};
  if (isTutor === 'true') {
    query = {
      where: {
        tutorId: id,
      },
      include: {
        model: User,
        as: 'studentInfo',
      },
    };
  } else {
    query = {
      where: {
        studentId: id,
      },
      include: {
        model: User,
        as: 'tutorInfo',
      },
    };
  }
  return await CallSession.findAndCountAll({
    ...query,
    ...paginate({ page, perPage }),
    order: [['startTime', 'DESC']],
  });
};

export default callSessionService;
