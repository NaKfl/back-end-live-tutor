import { onlineUsers } from '../controllers';

const callHandler = (io, socket) => {
  socket.on('call:callVideo', async ({ userId }) => {
    console.log({ userId });
    const socketIds = await onlineUsers.getSocketIdsByUserId(userId);
    const userCall = await onlineUsers.getUserBySocketId(socket.id);
    console.log('socket.id', onlineUsers, socket.id);
    console.log('userCall', userCall);
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:notifyCall', {
        userCall,
      }),
    );
  });
  socket.on('call:acceptCall', async ({ userId }) => {
    const userBeCalled = await onlineUsers.getUserBySocketId(socket.id);
    const userCall = await onlineUsers.getUserById(userId);
    const socketIds = [...(await onlineUsers.getSocketIdsByUserId(userId))];
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:acceptedCall', {
        userCall,
        userBeCalled,
      }),
    );
  });
};

export default callHandler;
