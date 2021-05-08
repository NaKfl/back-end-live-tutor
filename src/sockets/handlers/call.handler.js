import { onlineUsers } from '../controllers';
import jwt from 'jsonwebtoken';
import { jwt as jwtVar } from 'configs/vars';

const callHandler = (io, socket) => {
  socket.on('call:callVideo', async ({ userId }) => {
    const socketIds = await onlineUsers.getSocketIdsByUserId(userId);
    const userCall = await onlineUsers.getUserBySocketId(socket.id);
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:notifyCall', {
        userCall,
      }),
    );
  });
  socket.on('call:acceptCall', async ({ userId, startTime }) => {
    const userAccepted = await onlineUsers.getUserBySocketId(socket.id);
    const userCall = await onlineUsers.getUserById(userId);
    const socketIds = [
      ...(await onlineUsers.getSocketIdsByUserId(userId)),
      ...(await onlineUsers.getSocketIdsByUserId(userAccepted.id)),
    ];
    const jwtRoom = jwt.sign({}, jwtVar.secret);
    const roomName = userAccepted.name + '-' + userCall.name;
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:acceptedCall', {
        userCall,
        userBeCalled: userAccepted,
        jwtRoom,
        roomName,
        startTime,
      }),
    );
  });

  socket.on('call:cancelCall', async ({ userId }) => {
    const userCancel = await onlineUsers.getUserBySocketId(socket.id);
    const userBeCalled = await onlineUsers.getUserById(userId);
    const socketIds = [...(await onlineUsers.getSocketIdsByUserId(userId))];
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:canceledCall', {
        userCall: userCancel,
        userBeCalled,
      }),
    );
  });
};

export default callHandler;
