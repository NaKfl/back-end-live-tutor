import Joi from 'joi';

const paymentValidation = {};

paymentValidation.getWallet = {
  body: Joi.object({}),
  params: Joi.object({}),
  query: Joi.object({}),
};

paymentValidation.deposit = {
  body: Joi.object({
    price: Joi.number().min(1).required(),
  }),
  params: Joi.object({}),
  query: Joi.object({}),
};

export default paymentValidation;
