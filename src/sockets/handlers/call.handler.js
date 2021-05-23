import { tutorService } from 'services';
import callSessionService from 'services/callSession.service';
import { onlineUsers } from '../controllers';
import { v4 as uuidv4 } from 'uuid';

const callHandler = (io, socket) => {
  socket.on('call:callVideo', async ({ userId }) => {
    const socketIds = await onlineUsers.getSocketIdsByUserId(userId);
    const userCallInfo = await onlineUsers.getUserBySocketId(socket.id);
    let userCall = userCallInfo;
    if (!userCallInfo.name) {
      userCall = {
        ...userCallInfo,
        name: 'Someone',
      };
    }
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
    const roomName = uuidv4();
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:acceptedCall', {
        userCall,
        userBeCalled,
        roomName,
        startTime,
      }),
    );
  });

  socket.on('call:cancelCall', async ({ userId }) => {
    const userBeCalled = await onlineUsers.getUserBySocketId(socket.id);
    const userCall = await onlineUsers.getUserById(userId);
    const socketIds = [...(await onlineUsers.getSocketIdsByUserId(userId))];
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:cancelCalled', {
        userCall,
        userBeCalled,
      }),
    );
  });

  socket.on(
    'call:endCall',
    async ({ userCall, userBeCalled, startTime, endTime }) => {
      setTimeout(async () => {
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
      }, 3000);
    },
  );
};

export default callHandler;
