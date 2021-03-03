import Joi from 'joi';

const tutorValidation = {};

tutorValidation.getMany = {
  query: Joi.object({
    page: Joi.number().min(1),
    perPage: Joi.number().min(1),
  }),
};

tutorValidation.register = {
  body: Joi.object({
    // avatar: Joi.string().required(),
    // video: Joi.string().required(),
    name: Joi.string().required(),
    country: Joi.string().required(),
    birthday: Joi.string().required(),
    education: Joi.string().required(),
    experience: Joi.string().required(),
    profession: Joi.string().required(),
    languages: Joi.array().required(),
    accent: Joi.string().required(),
    bio: Joi.string().required(),
    targetStudent: Joi.string().required(),
    specialties: Joi.array().required(),
  }),
};

export default tutorValidation;
