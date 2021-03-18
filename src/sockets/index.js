import chatHandler from './chat.handler';
import identityHandler from './identity.handler';

const initSockets = (io) => {
  io.on('connection', async (socket) => {
    identityHandler(io, socket);
    chatHandler(io, socket);
  });
};

export default initSockets;
