import { TutorFeedback, CallSession } from 'database/models';
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

export default feedbackService;
