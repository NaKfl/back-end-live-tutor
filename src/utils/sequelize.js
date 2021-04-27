export const paginate = ({ page = 1, perPage = 20 }) => {
  const order = [['updatedAt', 'DESC']];
  const offset = perPage * (page - 1);
  const limit = perPage;

  return {
    order,
    offset,
    limit,
  };
};

const constKey = [
  'education',
  'bio',
  'experience',
  'profession',
  'accent',
  'targetStudent',
  'interests',
  'resume',
];
export const searchHelp = ({ Op, keys, searchKey }) => {
  return constKey.reduce((pre, now) => {
    return [
      ...pre,
      Object.assign({}, { [now]: { [Op.like]: `%${searchKey}%` } }),
    ];
  }, []);
};

export const SetById = (dataArray) => {
  let key = [];
  let result = [];
  for (let i = 0; i < dataArray.length; i++) {
    if (key.includes(dataArray[i].dataValues.id)) {
      delete dataArray[i];
    } else {
      key.push(dataArray[i].dataValues.id);
      result.push(dataArray[i]);
    }
  }
  return result;
};
