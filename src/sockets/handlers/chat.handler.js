import { onlineUsers } from '../controllers';
import { messageService } from 'services';

const chatHandler = (io, socket) => {
  const returnMessages = async ({ fromId, toId }) => {
    const socketIds = [
      ...(await onlineUsers.getSocketIdsByUserId(fromId)),
      ...(await onlineUsers.getSocketIdsByUserId(toId)),
    ];
    const messages = await messageService.getManyByUserIds(fromId, toId);
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('chat:returnMessages', {
        messages,
      }),
    );
  };

  const returnRecentList = async (userId) => {
    const socketIds = await onlineUsers.getSocketIdsByUserId(userId);
    const recentList = await messageService.getRecentConversations(userId);

    socketIds.forEach((socketId) =>
      io.to(socketId).emit('chat:returnRecentList', {
        recentList,
      }),
    );
  };

  socket.on('chat:getRecentList', async () => {
    const user = await onlineUsers.getUserBySocketId(socket.id);
    returnRecentList(user?.id);
  });

  socket.on('chat:getMessages', async ({ fromId, toId }) => {
    returnMessages({ fromId, toId });
  });

  socket.on('chat:sendMessage', async ({ fromId, toId, content }) => {
    await messageService.createOne({
      fromId,
      toId,
      content,
      createdAt: new Date(),
    });
    returnMessages({ fromId, toId });
    returnRecentList(fromId);
    returnRecentList(toId);
  });

  socket.on('connection:login', () => {
    socket.broadcast.emit('chat:joinOrLeave');
  });

  socket.on('disconnect', () => {
    socket.broadcast.emit('chat:joinOrLeave');
  });
};

export default chatHandler;
