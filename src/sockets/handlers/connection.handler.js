import { onlineUsers } from '../controllers';
import User from '../models/user.model';
import { tutorService } from 'services';

const connectionHandler = (io, socket) => {
  socket.on('connection:login', async ({ user }) => {
    socket.user = user;
    const newUser = new User(user);
    await onlineUsers.add(newUser, socket.id);

    const listTutor = await tutorService.getAllOnlineTutors();
    io.emit('onlineTutors:returnList', {
      listTutor,
    });
  });
};

export default connectionHandler;
