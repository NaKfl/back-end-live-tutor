import Joi from 'joi';

const bookingValidation = {};

bookingValidation.book = {
  body: Joi.object({
    scheduleDetailIds: Joi.array()
      .items(Joi.string().guid().required())
      .required(),
  }),
};

bookingValidation.cancelBooking = {
  body: Joi.object({
    scheduleDetailIds: Joi.array()
      .items(Joi.string().guid().required())
      .required(),
  }),
};

export default bookingValidation;
