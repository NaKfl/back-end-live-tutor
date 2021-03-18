import { onlineUsers } from './models';
import { messageService } from 'services';

const chatHandler = (io, socket) => {
  socket.on('chat:getInitiatedMessages', async ({ fromId, toId }) => {
    const messages = await messageService.getManyByUserIds(fromId, toId);
    socket.emit('chat:returnInitiatedMessages', {
      messages,
    });
  });

  socket.on('chat:sendMessage', async ({ fromId, toId, content }) => {
    await messageService.createOne({
      fromId,
      toId,
      content,
      createdAt: new Date(),
    });
    const messages = await messageService.getManyByUserIds(fromId, toId);
    socket.emit('chat:returnInitiatedMessages', {
      messages,
    });
  });
};

export default chatHandler;
