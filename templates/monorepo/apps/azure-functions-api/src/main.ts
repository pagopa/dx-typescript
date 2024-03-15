import { app } from "@azure/functions";
import { getConfigOrThrow } from "./config";
import { InfoFn } from "./functions/info";

const _config = getConfigOrThrow();

const Info = InfoFn({});
app.http("Info", {
  authLevel: "anonymous",
  handler: Info,
  methods: ["GET"],
  route: "info"
});
