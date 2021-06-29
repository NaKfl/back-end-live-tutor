import { sequelize, CallSession, User, TutorFeedback } from 'database/models';
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
      return CallSession.create(
        { studentId, tutorId, startTime, endTime },
        { lock: true, transaction: t },
      );
    }
  });
  return session;
};

callSessionService.getOne = async ({ studentId, tutorId, startTime }) => {
  const existedSession = await CallSession.findOne({
    where: {
      studentId,
      tutorId,
      startTime,
    },
  });
  if (existedSession) {
    return existedSession;
  } else {
    return null;
  }
};

callSessionService.getSessionByStudentId = async ({
  id,
  page = 1,
  perPage = 10,
  isTutor = false,
}) => {
  let query = {};
  page = +page;
  perPage = +perPage;
  if (isTutor === 'true') {
    query = {
      where: {
        tutorId: id,
      },
      include: [
        {
          model: User,
          as: 'studentInfo',
          include: [
            {
              model: TutorFeedback,
              as: 'feedbacks',
              include: [
                {
                  model: User,
                  as: 'firstInfo',
                  attributes: {
                    exclude: ['id', 'password'],
                  },
                },
              ],
            },
          ],
        },
      ],
    };
  } else {
    query = {
      where: {
        studentId: id,
      },
      include: [
        {
          model: User,
          as: 'tutorInfo',
          attributes: {
            exclude: ['password'],
          },
          include: [
            {
              model: TutorFeedback,
              as: 'feedbacks',
              include: [
                {
                  model: User,
                  as: 'secondInfo',
                  attributes: {
                    exclude: ['id', 'password'],
                  },
                },
              ],
            },
          ],
        },
      ],
    };
  }

  return CallSession.findAndCountAll({
    ...query,
    ...paginate({ page, perPage }),
    distinct: true,
    order: [['createdAt', 'DESC']],
  });
};

export default callSessionService;
