import { onlineUsers } from '../models';
import User from '../models/user.model';

const identityHandler = (io, socket) => {
  socket.on('identity', async ({ user }) => {
    socket.user = user;
    const newUser = new User(user);
    await onlineUsers.add(newUser, socket.id);
  });

  socket.on('disconnect', async () => {
    if (socket.user) await onlineUsers.remove(socket.user, socket.id);
  });

  socket.on('logout', async () => {
    if (socket.user) await onlineUsers.remove(socket.user, socket.id);
  });
};

export default identityHandler;
