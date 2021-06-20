import Joi from 'joi';
import { nameRegex } from 'utils/regex';

const userValidation = {};

userValidation.updateInfo = {
  body: Joi.object({
    email: Joi.string().email(),
    name: Joi.string(),
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
