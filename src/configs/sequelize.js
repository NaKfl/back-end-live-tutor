import { sequelize } from 'database/models';
import logger from 'configs/logger';

const connectDatabase = () => {
  sequelize
    .authenticate()
    .then(() => logger.info('Successfully connected to the database'))
    .catch((error) => {
      logger.error(
        `Could not connect to the database. Exiting now...\n${error}`,
      );
      process.exit(-1);
    });
};

export default connectDatabase;
