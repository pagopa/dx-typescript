import { app } from "@azure/functions";
import { getConfigOrError } from "./config";
import { InfoFn } from "./functions/info";
import { pipe } from "fp-ts/lib/function";
import * as E from "fp-ts/Either";

const _config = pipe(
  getConfigOrError(),
  E.getOrElseW((error) => {
    throw error;
  })
);

const Info = InfoFn({});
app.http("Info", {
  authLevel: "anonymous",
  handler: Info,
  methods: ["GET"],
  route: "info"
});
