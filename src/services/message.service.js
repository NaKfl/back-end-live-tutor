import { Message, User } from 'database/models';
import { Op } from 'sequelize';

const messageService = {};

messageService.createOne = async (data) => {
  const newMessage = await Message.create(data);
  return newMessage;
};

messageService.getManyByUserIds = async (fromId, toId) => {
  const messages = await Message.findAll({
    order: [['createdAt', 'ASC']],
    include: [
      {
        model: User,
        as: 'fromInfo',
        attributes: ['name'],
        where: {
          [Op.or]: [{ id: fromId }, { id: toId }],
        },
      },
      {
        model: User,
        as: 'toInfo',
        attributes: ['name'],
        where: {
          [Op.or]: [{ id: fromId }, { id: toId }],
        },
      },
    ],
  });
  return messages;
};

export default messageService;
