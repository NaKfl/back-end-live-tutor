import Joi from 'joi';
import { nameRegex } from 'utils/regex';

const userValidation = {};

userValidation.updateInfo = {
  body: Joi.object({
    email: Joi.string().email(),
    name: Joi.string().pattern(nameRegex),
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
export default userValidation;
