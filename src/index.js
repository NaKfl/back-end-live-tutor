import server from 'configs/express';
import connectDatabase from 'configs/sequelize';
import { port, env } from './configs/vars';
import logger from './configs/logger';

connectDatabase();

server.listen(port, () =>
  logger.info(`Server started on port ${port} (${env})`),
);

export default server;
