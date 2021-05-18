import chatHandler from './handlers/chat.handler';
import connectionHandler from './handlers/connection.handler';
import disconnectionHandler from './handlers/disconnection.handler';
import callHandler from './handlers/call.handler';
import onlineTutorsHandler from './handlers/onlineTutors.handler';

const initSockets = (io) => {
  io.on('connection', async (socket) => {
    connectionHandler(io, socket);

    // Insert new socket handlers between connection and disconnection handler
    chatHandler(io, socket);
    callHandler(io, socket);
    onlineTutorsHandler(io, socket);
    disconnectionHandler(io, socket);
  });
};

export default initSockets;
