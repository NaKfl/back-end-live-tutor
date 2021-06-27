import { Report } from 'database/models';

const reportService = {};

reportService.createReport = async (id, data) => {
  const { tutorId, content } = data;
  return await Report.create({
    userId: id,
    tutorId,
    content,
  });
};

export default reportService;
