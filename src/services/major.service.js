import { Major } from 'database/models';

const majorService = {};

majorService.getAll = async () => {
  return await Major.findAll();
};

export default majorService;
