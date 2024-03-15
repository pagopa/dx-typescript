import { CosmosClient } from "@azure/cosmos";
import { app } from "@azure/functions";
import { getConfigOrThrow } from "./config";
import { InfoFn } from "./functions/info";
import { CreateRedisClientSingleton } from "./utils/redis/client";
import { GenerateNonceFn } from "./functions/generate-nonce";

const config = getConfigOrThrow();

const cosmosClient = new CosmosClient(config.COSMOS_CONNECTION_STRING);
const database = cosmosClient.database(config.COSMOS_DB_NAME);

const redisClientTask = CreateRedisClientSingleton(config);

const Info = InfoFn({ db: database, redisClientTask });
app.http("Info", {
  authLevel: "anonymous",
  handler: Info,
  methods: ["GET"],
  route: "info"
});

const GenerateNonce = GenerateNonceFn({ redisClientTask });
app.http("Info", {
  authLevel: "function",
  handler: GenerateNonce,
  methods: ["GET"],
  route: "api/v1/nonce/generate"
});
