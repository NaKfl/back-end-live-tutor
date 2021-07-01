import { Notification } from 'database/models';
import notify from 'utils/notify';

const notificationService = {};

notificationService.addMessage = async (data) => {
  const { title, body } = data;

  const rawTokens = await Notification.findAll({
    attributes: ['token'],
  });
  const tokens = rawTokens.map((token) => token.token);

  notify(tokens, {
    title,
    body,
  });
};

notificationService.registerToken = async (data) => {
  const { token } = data;

  const existedToken = await Notification.findByPk(token);

  if (!existedToken) {
    await Notification.create({
      token,
    });
  }
};

export default notificationService;
