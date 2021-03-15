import { TutorFeedback } from 'database/models';
const feedbackService = {};

feedbackService.feedbackTutor = async ({
  firstId,
  secondId,
  content,
  rating,
}) => {
  return await TutorFeedback.create({
    firstId,
    secondId,
    content,
    rating,
  });
};
export default feedbackService;
