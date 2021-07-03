import { FeeTutor } from 'database/models';

const feeTutorService = {};

feeTutorService.getFeeOfTutor = async (id) => {
  const vndFee = await FeeTutor.findOne({
    where: {
      tutorId: id,
    },
  });
  if (vndFee) {
    const {
      dataValues: { price },
    } = vndFee;
    return { price: +price };
  } else {
    return { price: 0 };
  }
};

feeTutorService.setFeeOfTutor = async (id, newPrice) => {
  const defaultPrice = await FeeTutor.findOne({ where: { tutorId: id } });
  if (defaultPrice) {
    if (newPrice) {
      defaultPrice.price = newPrice;
      await defaultPrice.save();
    }
    const {
      dataValues: { price },
    } = defaultPrice;
    return { price: price || 0 };
  } else {
    const initPriceOfTutor = await FeeTutor.create({
      tutorId: id,
      price: newPrice,
    });
    const {
      dataValues: { price },
    } = initPriceOfTutor;
    return { price: +price || 0 };
  }
};

feeTutorService.createFeeOfTutor = async (id, initPrice) => {
  const initPriceOfTutor = await FeeTutor.create({
    tutorId: id,
    price: initPrice,
  });
  const {
    dataValues: { price },
  } = initPriceOfTutor;
  return { price: +price || 0 };
};

export default feeTutorService;
