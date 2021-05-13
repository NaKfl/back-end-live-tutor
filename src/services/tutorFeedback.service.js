import { TutorFeedback, CallSession } from 'database/models';
const feedbackService = {};

feedbackService.feedbackTutor = async ({
  sessionId,
  firstId,
  secondId,
  content,
  rating,
}) => {
  const feedback = await TutorFeedback.findOne({
    where: {
      firstId,
      secondId,
    },
  });
  if (feedback) {
    const fields = {
      content,
      rating,
    };
    await TutorFeedback.update(fields, {
      where: {
        firstId,
        secondId,
      },
    });
    const data = await TutorFeedback.findOne({
      where: {
        firstId,
        secondId,
      },
    });
    return data;
  } else {
    const review = await TutorFeedback.create({
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
    return review;
  }
};

export default feedbackService;
