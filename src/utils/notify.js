import { messaging } from 'configs/firebase';
import logger from 'configs/logger';

const sendNotificationToClient = async (tokens, data) => {
  try {
    const res = await messaging.sendMulticast({ tokens, data });
    const { successCount, failureCount } = res;
    logger.info(
      `Notifications sent: ${successCount} successful, ${failureCount} failed`,
    );
  } catch (error) {
    logger.error(`Error sending message: $}{error}`);
  }
};

export default sendNotificationToClient;
