import { onlineUsers } from '../controllers';
import { tutorService } from 'services';

const disconnectionHandler = (io, socket) => {
  socket.on('disconnect', async () => {
    const user = await onlineUsers.getUserBySocketId(socket.id);
    if (user) await onlineUsers.remove(user, socket.id);

    const listTutor = await tutorService.getAllOnlineTutors();
    io.emit('onlineTutors:returnList', {
      listTutor,
    });
  });

  socket.on('disconnection:logout', async () => {
    const user = await onlineUsers.getUserBySocketId(socket.id);
    if (user) await onlineUsers.remove(user, socket.id);

    const listTutor = await tutorService.getAllOnlineTutors();
    io.emit('onlineTutors:returnList', {
      listTutor,
    });
  });
};

export default disconnectionHandler;
