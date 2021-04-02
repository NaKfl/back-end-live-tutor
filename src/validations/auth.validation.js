import Joi from 'joi';

const authValidation = {};

authValidation.register = {
  body: Joi.object({
    name: Joi.string()
      .regex(/^([a-zA-Z]+\s)*[a-zA-Z]+$/)
      .min(2)
      .max(50),
    email: Joi.string().required().email(),
    password: Joi.string().required().min(6).max(128),
  }),
};

authValidation.login = {
  body: Joi.object({
    email: Joi.string().required().email(),
    password: Joi.string().required(),
  }),
};

authValidation.oAuth = {
  body: Joi.object({
    access_token: Joi.string().required(),
  }),
};

export default authValidation;
