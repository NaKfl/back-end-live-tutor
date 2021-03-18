import server from 'configs/express';
import connectDatabase from 'configs/sequelize';
import { port, env } from './configs/vars';

connectDatabase();

server.listen(port, () =>
  console.log(`server started on port ${port} (${env})`),
);

export default server;
