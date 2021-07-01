import Joi from 'joi';

const notificationValidation = {};

notificationValidation.addMessage = {
  body: Joi.object({
    title: Joi.string().required(),
    body: Joi.string().required(),
  }),
};

notificationValidation.registerToken = {
  body: Joi.object({
    token: Joi.string().required(),
  }),
};

export default notificationValidation;
