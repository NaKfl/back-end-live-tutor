import { tutorService } from 'services';
import callSessionService from 'services/callSession.service';
import { onlineUsers } from '../controllers';

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
    const userBeCalled = await onlineUsers.getUserBySocketId(socket.id);
    const userCall = await onlineUsers.getUserById(userId);
    const socketIds = [
      ...(await onlineUsers.getSocketIdsByUserId(userId)),
      ...(await onlineUsers.getSocketIdsByUserId(userBeCalled.id)),
    ];
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:acceptedCall', {
        userCall,
        userBeCalled,
        startTime,
      }),
    );
  });

  socket.on(
    'call:endCall',
    async ({ userCall, userBeCalled, startTime, endTime }) => {
      const socketIds = [
        ...(await onlineUsers.getSocketIdsByUserId(userCall.id)),
      ];
      const tutor = await tutorService.getOne(userBeCalled.id);
      const session = await callSessionService.add({
        studentId: userCall.id,
        tutorId: userBeCalled.id,
        startTime,
        endTime,
      });
      socketIds.forEach((socketId) =>
        io.to(socketId).emit('call:endedCall', {
          userCall,
          tutor,
          session,
        }),
      );
    },
  );
};

export default callHandler;
