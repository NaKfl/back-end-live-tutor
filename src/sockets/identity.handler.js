import { onlineUsers } from './models';
import User from './models/user.model';

const identityHandler = (io, socket) => {
  socket.on('identity', ({ user }) => {
    socket.user = user;
    const newUser = new User(user);
    onlineUsers.add(newUser, socket.id);
  });

  socket.on('disconnect', async () => {
    if (socket.user) onlineUsers.remove(socket.user, socket.id);
  });

  socket.on('logout', async () => {
    if (socket.user) onlineUsers.remove(socket.user, socket.id);
    console.log('onlineUsers.getAll()', onlineUsers.getAll());
  });
};

export default identityHandler;
