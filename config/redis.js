import redis from 'redis'
const client = redis.createClient({
  url: `redis://${process.env.REDIS_HOST}:${process.env.REDIS_PORT}`,
  password: process.env.REDIS_PASS,
  pingInterval: 30000,
});
client.on('error', (err) => console.error('Redis 连接错误:', err));
client.on('connect', () => console.log('Redis 已连接'));
client.connect();
export default client
