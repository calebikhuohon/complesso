const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    retry_strategy: () => 1000
});
// const sub = redisClient.duplicate();

function fib(index) {
    console.log('-----index',index);
    if (index < 2) return 1;
    const result = fib(index - 1) + fib(index - 2);
    console.log('---------result', result);
    return result;
}

redisClient.on('message', (channel, message) => {
    console.log('message',message);
    redisClient.hset('values', message, fib(parseInt(message)));
});
redisClient.subscribe('insert');