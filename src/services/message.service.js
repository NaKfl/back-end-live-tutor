import { Message, User } from 'database/models';
import { Op } from 'sequelize';
import moment from 'moment';
import { onlineUsers } from 'sockets/controllers';

const messageService = {};

messageService.createOne = async (data) => {
  const newMessage = await Message.create(data);
  return newMessage;
};

messageService.getManyByUserIds = async (fromId, toId) => {
  const messages = await Message.findAll({
    attributes: {
      exclude: ['fromId', 'toId'],
    },
    order: [['createdAt', 'ASC']],
    include: [
      {
        model: User,
        as: 'fromInfo',
        attributes: ['id', 'name'],
        where: {
          [Op.or]: [{ id: fromId }, { id: toId }],
        },
      },
      {
        model: User,
        as: 'toInfo',
        attributes: ['id', 'name'],
        where: {
          [Op.or]: [{ id: fromId }, { id: toId }],
        },
      },
    ],
  });
  return messages;
};

messageService.getRecentConversations = async (userId) => {
  const haveTextedAlreadyIds = await Message.findAll({
    attributes: ['fromId', 'toId'],
    group: ['fromId', 'toId'],
    where: {
      [Op.or]: [{ fromId: userId }, { toId: userId }],
    },
  });

  const recentIds = haveTextedAlreadyIds
    .map((item) => item.dataValues)
    .map((item) => [item.fromId, item.toId])
    .flat()
    .filter((item) => item !== userId);

  const distinctRecentIds = [...new Set(recentIds)];

  const lastConversationPromises = distinctRecentIds.map((id) =>
    Message.findAll({
      attributes: {
        exclude: ['fromId', 'toId'],
      },
      limit: 1,
      order: [['createdAt', 'DESC']],
      where: {
        [Op.or]: [
          {
            [Op.and]: [{ fromId: userId }, { toId: id }],
          },
          {
            [Op.and]: [{ fromId: id }, { toId: userId }],
          },
        ],
      },
      include: [
        {
          model: User,
          as: 'fromInfo',
          attributes: ['id', 'name', 'avatar'],
        },
        {
          model: User,
          as: 'toInfo',
          attributes: ['id', 'name', 'avatar'],
        },
      ],
    }),
  );

  const lastConversation = await Promise.all(lastConversationPromises);

  const sortedLastConversation = lastConversation
    .filter((item) => item[0])
    .map((item) => item[0].dataValues)
    .sort((a, b) => moment(b.createdAt) - moment(a.createdAt));

  const checkOnlineConversationPromises = sortedLastConversation.map(
    async (item) => {
      const { fromInfo, toInfo } = item;
      const partner = userId !== fromInfo?.id ? fromInfo : toInfo;
      return {
        ...item,
        partner: {
          ...partner.dataValues,
          isOnline: await onlineUsers.isUserOnline(partner?.id),
        },
      };
    },
  );

  const checkOnlineConversation = await Promise.all(
    checkOnlineConversationPromises,
  );

  return checkOnlineConversation;
};

export default messageService;
