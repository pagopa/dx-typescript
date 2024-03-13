import * as redis from "redis";
import * as TE from "fp-ts/lib/TaskEither";

export type RedisDependency = {
  readonly redisClientTask: TE.TaskEither<Error, redis.RedisClientType>;
};
