import chatHandler from './handlers/chat.handler';
import identityHandler from './handlers/identity.handler';

const initSockets = (io) => {
  io.on('connection', async (socket) => {
    identityHandler(io, socket);
    chatHandler(io, socket);
  });
};

export default initSockets;
