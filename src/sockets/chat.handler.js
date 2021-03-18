import { onlineUsers } from './models';
import { messageService } from 'services';

const chatHandler = (io, socket) => {
  const returnMessages = async ({ fromId, toId }) => {
    const socketIds = [
      ...onlineUsers.getSocketIdsByUserId(fromId),
      ...onlineUsers.getSocketIdsByUserId(toId),
    ];
    const messages = await messageService.getManyByUserIds(fromId, toId);
    socketIds.forEach((socketId) =>
      io.to(socketId).emit('chat:returnInitiatedMessages', {
        messages,
      }),
    );
  };

  socket.on('chat:getInitiatedMessages', async ({ fromId, toId }) => {
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
  });
};

export default chatHandler;
