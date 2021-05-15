import { TutorFeedback, CallSession } from 'database/models';
const feedbackService = {};

feedbackService.feedbackTutor = async ({
  sessionId,
  firstId,
  secondId,
  content,
  rating,
}) => {
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
};

export default feedbackService;
