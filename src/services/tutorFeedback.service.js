import e from 'cors';
import { TutorFeedback } from 'database/models';
const feedbackService = {};

feedbackService.feedbackTutor = async ({
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
    return await TutorFeedback.update(fields, {
      where: {
        firstId,
        secondId,
      },
    });
  } else {
    return await TutorFeedback.create({
      firstId,
      secondId,
      content,
      rating,
    });
  }
};

export default feedbackService;
