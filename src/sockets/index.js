import chatHandler from './handlers/chat.handler';
import connectionHandler from './handlers/connection.handler';
import disconnectionHandler from './handlers/disconnection.handler';

const initSockets = (io) => {
  io.on('connection', async (socket) => {
    connectionHandler(io, socket);

    // Insert new socket handlers between connection and disconnection handler
    chatHandler(io, socket);

    disconnectionHandler(io, socket);
  });
};

export default initSockets;
