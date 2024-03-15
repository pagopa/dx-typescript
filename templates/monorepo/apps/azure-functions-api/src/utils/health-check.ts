import {
  HealthCheck,
  ProblemSource
} from "@pagopa/io-functions-commons/dist/src/utils/healthcheck";
import * as TE from "fp-ts/lib/TaskEither";

export type HealthCheckBuilder = <T, S extends ProblemSource<S>>(
  dependency: T
) => HealthCheck<S>;

export type DummyProblemSource = "Dummy";

export const dummyHelthCheck = (): HealthCheck<DummyProblemSource> =>
  TE.of(true);
