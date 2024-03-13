import { CosmosClient } from "@azure/cosmos";
import { getConfigOrThrow } from "./config";
import { InfoFn } from "./functions/info";
import { CreateRedisClientSingleton } from "./utils/redis/client";
import { GenerateNonceFn } from "./functions/generate-nonce";

const config = getConfigOrThrow();

const cosmosClient = new CosmosClient(config.COSMOS_CONNECTION_STRING);
const database = cosmosClient.database(config.COSMOS_DB_NAME);

const redisClientTask = CreateRedisClientSingleton(config);

export const Info = InfoFn({ db: database, redisClientTask });
export const GenerateNonce = GenerateNonceFn({ redisClientTask });
