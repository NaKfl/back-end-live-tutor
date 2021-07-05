import Joi from 'joi';

const tutorValidation = {};

tutorValidation.tutorAdd = {
  params: Joi.object({
    id: Joi.string().required().guid(),
  }),
};

tutorValidation.tutorRemove = {
  params: Joi.object({
    id: Joi.string().required().guid(),
  }),
};

export default tutorValidation;
