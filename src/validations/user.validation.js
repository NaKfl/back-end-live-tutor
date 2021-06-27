import Joi from 'joi';

const userValidation = {};

userValidation.updateInfo = {
  body: Joi.object({
    email: Joi.string().email(),
    name: Joi.string()
      .regex(/^([a-zA-Z]|[à-ú]|[À-Ú]+\s)*[a-zA-Z]|[à-ú]|[À-Ú]+$/)
      .min(1)
      .max(50),
    avatar: Joi.string().allow(null, ''),
    country: Joi.string().allow(null, ''),
    phone: Joi.string().allow(null, ''),
    language: Joi.string().allow(null, ''),
    birthday: Joi.string().allow(null, ''),
  }),
};

userValidation.manageFavoriteTutor = {
  body: Joi.object({
    tutorId: Joi.string().required(),
  }),
};

userValidation.feedbackTutor = {
  body: Joi.object({
    sessionId: Joi.string().required(),
    tutorId: Joi.string().required(),
    rating: Joi.number().required(),
    content: Joi.string().allow(null, ''),
  }),
};

userValidation.forgotPassword = {
  body: Joi.object({
    email: Joi.string().required().email(),
  }),
};

export default userValidation;
