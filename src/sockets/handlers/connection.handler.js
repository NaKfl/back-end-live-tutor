import { onlineUsers } from '../controllers';
import User from '../models/user.model';

const connectionHandler = (io, socket) => {
  socket.on('connection:login', async ({ user }) => {
    socket.user = user;
    const newUser = new User(user);
    await onlineUsers.add(newUser, socket.id);
  });
};

export default connectionHandler;
