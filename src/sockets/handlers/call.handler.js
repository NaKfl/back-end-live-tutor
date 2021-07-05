import callSessionService from 'services/callSession.service';
import { onlineUsers } from '../controllers';
import { v4 as uuidv4 } from 'uuid';

const callHandler = (io, socket) => {
  socket.on('call:callVideo', async ({ userId }) => {
    const userCallInfo = await onlineUsers.getUserBySocketId(socket.id);
    const userBeCalled = await onlineUsers.getUserById(userId);
    const socketIdsBeCalled = await onlineUsers.getSocketIdsByUserId(userId);
    const socketIdsUserCall = await onlineUsers.getSocketIdsByUserId(
      userCallInfo.id,
    );
    if (userBeCalled.isCalling) {
      socketIdsUserCall.forEach((socketId) =>
        io.to(socketId).emit('call:canNotCallTutor', {
          userBeCalled,
        }),
      );
    } else {
      let userCall = userCallInfo;
      if (!userCallInfo.name) {
        userCall = {
          ...userCallInfo,
          name: 'Someone',
        };
      }
      await onlineUsers.setStatusCalling(userBeCalled.id, true);
      socketIdsBeCalled.forEach((socketId) =>
        io.to(socketId).emit('call:notifyCall', {
          userCall,
        }),
      );
      socketIdsUserCall.forEach((socketId) =>
        io.to(socketId).emit('call:canCallTutor', {
          userBeCalled,
        }),
      );
    }
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
    await onlineUsers.setStatusCalling(userBeCalled.id, false);
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:cancelCalled', {
        userCall,
        userBeCalled,
      }),
    );
  });

  socket.on('call:selfCancelCall', async ({ userId }) => {
    const socketIds = [...(await onlineUsers.getSocketIdsByUserId(userId))];
    await onlineUsers.setStatusCalling(userId, false);
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('call:selfCancelCalled'),
    );
  });

  socket.on('call:setStatusCalling', async ({ userId, status }) => {
    await onlineUsers.setStatusCalling(userId, status);
  });

  socket.on(
    'call:endCall',
    async ({ userCall, userBeCalled, startTime, endTime }) => {
      setTimeout(async () => {
        const socketIdsUserCall = [
          ...(await onlineUsers.getSocketIdsByUserId(userCall.id)),
        ];
        const socketIdsUserBeCalled = [
          ...(await onlineUsers.getSocketIdsByUserId(userBeCalled.id)),
        ];
        const existedSession = await callSessionService.getOne({
          studentId: userCall.id,
          tutorId: userBeCalled.id,
          startTime,
        });
        if (!existedSession) {
          const session = await callSessionService.add({
            studentId: userCall.id,
            tutorId: userBeCalled.id,
            startTime,
            endTime,
          });
          await onlineUsers.setStatusCalling(userBeCalled.id, false);
          socketIdsUserCall.forEach((socketId) =>
            io.to(socketId).emit('call:endedCall', {
              userCall,
              userBeCalled,
              session,
            }),
          );
          socketIdsUserBeCalled.forEach((socketId) =>
            io.to(socketId).emit('call:endedCallTutor', {
              userCall,
              userBeCalled,
              session,
            }),
          );
        }
      }, 3000);
    },
  );
};

export default callHandler;
