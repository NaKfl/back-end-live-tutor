import { CallSession, sequelize, TutorFeedback, User } from 'database/models';

const feedbackService = {};

feedbackService.feedbackTutor = async ({
  sessionId,
  firstId,
  secondId,
  content,
  rating,
}) => {
  const existReview = await TutorFeedback.findOne({
    where: {
      sessionId,
      firstId,
      secondId,
    },
  });
  let review;
  if (existReview) {
    review = await TutorFeedback.update(
      {
        content,
        rating,
      },
      {
        where: {
          sessionId,
          firstId,
          secondId,
        },
      },
    );
  } else {
    review = await TutorFeedback.create({
      sessionId,
      firstId,
      secondId,
      content,
      rating,
    });
    await CallSession.update(
      {
        isReviewed: true,
      },
      {
        where: {
          id: sessionId,
        },
      },
    );
  }

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
      },
    ],
  });
  return { userInfo, avgRating: feedback.dataValues.avgRating };
};

feedbackService.getSessionFeedback = async (userId, sessionId) => {
  const feedback = await TutorFeedback.findOne({
    separate: true,
    attributes: [[sequelize.fn('AVG', sequelize.col('rating')), 'avgRating']],
    where: {
      sessionId,
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
        where: {
          sessionId,
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
      },
    ],
  });
  return { userInfo, avgRating: feedback.dataValues.avgRating };
};

export default feedbackService;
