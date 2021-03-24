import { onlineUsers } from '../controllers';

const disconnectionHandler = (io, socket) => {
  socket.on('disconnect', async () => {
    const user = await onlineUsers.getUserBySocketId(socket.id);
    if (user) await onlineUsers.remove(user, socket.id);
  });

  socket.on('disconnection:logout', async () => {
    const user = await onlineUsers.getUserBySocketId(socket.id);
    if (user) await onlineUsers.remove(user, socket.id);
  });
};

export default disconnectionHandler;
