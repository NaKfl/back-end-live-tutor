import Joi from 'joi';

const scheduleValidation = {};

scheduleValidation.getMany = {
  query: Joi.object({
    date: Joi.date(),
  }),
};

scheduleValidation.getScheduleDetails = {
  params: Joi.object({
    scheduleId: Joi.string().guid(),
  }),
};

scheduleValidation.register = {
  body: Joi.object({
    date: Joi.date().required(),
    startTime: Joi.string()
      .regex(/^(0?[1-9]|1[0-2]):[0-5][0-9]$/)
      .required(),
    endTime: Joi.string()
      .regex(/^(0?[1-9]|1[0-2]):[0-5][0-9]$/)
      .required(),
  }),
};

scheduleValidation.unregister = {
  params: Joi.object({
    scheduleId: Joi.string().guid(),
  }),
};

scheduleValidation.getFreeTimeDetails = {
  body: Joi.object({
    date: Joi.date().required(),
  }),
};

export default scheduleValidation;
