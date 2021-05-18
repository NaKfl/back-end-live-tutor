import { tutorService } from 'services';

const onlineTutorsHandler = (io, socket) => {
  const returnTutorsList = async () => {
    const listTutor = await tutorService.getAllOnlineTutors();
    io.emit('onlineTutors:returnList', {
      listTutor,
    });
  };

  socket.on('onlineTutors:getList', async () => {
    returnTutorsList();
  });
};

export default onlineTutorsHandler;
