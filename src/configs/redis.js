import bluebird from 'bluebird';
import redis from 'redis';
import { redis as redisVars } from 'configs/vars';

bluebird.promisifyAll(redis);

const client = redis.createClient({
  host: redisVars.host,
  port: redisVars.port,
  connectTimeout: 10000,
});

export default client;
