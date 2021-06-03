import { Category, Type } from 'database/models';
import { Op } from 'sequelize';

const categoryService = {};

categoryService.checkTypeHaveInTypeModel = async (type) => {
  if (type) {
    const types = await Type.findOne({
      where: {
        title: type,
      },
    });
    if (!types) {
      throw new Error('Type is not exist');
    }
    return true;
  }
};

categoryService.getAllByType = async (types) => {
  let inType = [];
  if (types) {
    if (Array.isArray(types)) {
      inType = types;
    } else {
      inType.push(types);
    }
  } else {
    inType = ['languages', 'specialties'];
  }
  return Type.findAll({
    where: {
      title: {
        [Op.in]: inType,
      },
    },
    include: [
      { model: Category, as: 'categories', attributes: ['id', 'description'] },
    ],
    attributes: ['id', 'title'],
  });
};
export default categoryService;
