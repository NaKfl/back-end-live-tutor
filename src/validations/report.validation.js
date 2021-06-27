import Joi from 'joi';

const reportValidation = {};

reportValidation.createReport = {
  body: Joi.object({
    tutorId: Joi.string().required(),
    content: Joi.string().required(),
  }),
};

export default reportValidation;
