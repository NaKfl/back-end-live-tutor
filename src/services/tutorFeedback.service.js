import { CallSession, sequelize, TutorFeedback, User } from 'database/models';

const feedbackService = {};

feedbackService.feedbackTutor = async ({
  sessionId,
  firstId,
  secondId,
  content,
  rating,
  isTutor,
}) => {
  const review = await TutorFeedback.create({
    sessionId,
    firstId,
    secondId,
    content,
    rating,
  });
  const needUpdate = isTutor ? { isTutorReviewed: true } : { isReviewed: true };

  await CallSession.update(
    {
      ...needUpdate,
    },
    {
      where: {
        id: sessionId,
      },
    },
  );

  return review;
};

feedbackService.getAllFeedbacks = async (userId) => {
  const feedback = await TutorFeedback.findOne({
    separate: true,
    attributes: [[sequelize.fn('AVG', sequelize.col('rating')), 'avgRating']],
    where: {
      secondId: userId,
    },
  });
  const userInfo = await User.findOne({
    where: {
      id: userId,
    },
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
            as: 'firstInfo',
            attributes: {
              exclude: ['password'],
            },
          },
          {
            model: User,
            as: 'secondInfo',
            attributes: {
              exclude: ['password'],
            },
          },
        ],
        order: [['createdAt', 'DESC']],
      },
    ],
  });
  return { userInfo, avgRating: feedback.dataValues.avgRating };
};

feedbackService.getSessionFeedback = async (sessionId, userId) => {
  const feedbacks = await TutorFeedback.findAll({
    where: {
      sessionId,
      firstId: userId,
    },
    include: [
      {
        model: User,
        as: 'firstInfo',
        attributes: {
          exclude: ['password'],
        },
      },
      {
        model: User,
        as: 'secondInfo',
        attributes: {
          exclude: ['password'],
        },
      },
    ],
    order: [['createdAt', 'DESC']],
  });
  return feedbacks;
};

export default feedbackService;
