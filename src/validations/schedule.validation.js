import Joi from 'joi';

const scheduleValidation = {};

scheduleValidation.getScheduleDetails = {
  params: Joi.object({
    scheduleId: Joi.string().guid(),
  }),
};

scheduleValidation.register = {
  body: Joi.object({
    date: Joi.date().required(),
    startTime: Joi.date().required(),
    endTime: Joi.date().required(),
  }),
};

scheduleValidation.unregister = {
  body: Joi.object({
    scheduleId: Joi.string().guid(),
  }),
};

export default scheduleValidation;
