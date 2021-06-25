import { ONLINE_USERS } from '../helpers/constants';
import redis from 'configs/redis';

class OnlineUsers {
  constructor() {
    if (OnlineUsers.instance) {
      return OnlineUsers.instance;
    }
    OnlineUsers.instance = this;
    redis.set(ONLINE_USERS, JSON.stringify({}));
  }

  async getAll() {
    return JSON.parse(await redis.getAsync(ONLINE_USERS));
  }

  async getAllIdsExcludeMe() {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    return (
      Object.values(users)
        .map((item) => item?.id)
        .reverse() ?? []
    );
  }

  async getUserById(userId) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    return users[userId] ?? null;
  }

  async isUserOnline(userId) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    return !!users[userId];
  }

  async getSocketIdsByUserId(userId) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    return users[userId]?.sockets ?? [];
  }

  async getUserBySocketId(socketId) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    return (
      Object.values(users).find((item) => item.sockets?.includes(socketId)) ??
      null
    );
  }

  async setStatusCalling(userId, status) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    const tutor = users[userId] ?? {};
    const updatedTutor = {
      ...tutor,
      isCalling: status,
    };
    users[userId] = updatedTutor;
    await redis.setAsync(ONLINE_USERS, JSON.stringify(users));
    return users;
  }

  async add(user, socketId) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    const { id } = user;
    if (users[id]) {
      users[id].sockets = [...new Set([...users[id].sockets, socketId])];
    } else {
      user.sockets.push(socketId);
      users[id] = user;
    }
    await redis.setAsync(ONLINE_USERS, JSON.stringify(users));
    return users;
  }

  async remove(user, socketId) {
    const users = JSON.parse(await redis.getAsync(ONLINE_USERS));
    const { id } = user;
    if (users[id])
      users[id].sockets = users[id]?.sockets?.filter?.(
        (item) => item !== socketId,
      );
    if (users[id]?.sockets && users[id].sockets.length === 0) delete users[id];
    await redis.setAsync(ONLINE_USERS, JSON.stringify(users));
    return users;
  }
}

export default OnlineUsers;
