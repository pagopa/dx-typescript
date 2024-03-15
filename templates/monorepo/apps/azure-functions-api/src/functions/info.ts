import { pipe } from "fp-ts/lib/function";
import * as Task from "fp-ts/lib/Task";
import * as RA from "fp-ts/lib/ReadonlyArray";
import * as H from "@pagopa/handler-kit";
import * as RTE from "fp-ts/lib/ReaderTaskEither";

import { HealthProblem } from "@pagopa/io-functions-commons/dist/src/utils/healthcheck";
import { httpAzureFunction } from "@pagopa/handler-kit-azure-func";
import { ApplicationInfo } from "../generated/definitions/internal/ApplicationInfo";
import { DummyProblemSource, dummyHelthCheck } from "../utils/health-check";
import { HealthCheckBuilder } from "../utils/health-check";

type ProblemSource = DummyProblemSource;
const applicativeValidation = RTE.getApplicativeReaderTaskValidation(
  Task.ApplicativePar,
  RA.getSemigroup<HealthProblem<ProblemSource>>()
);

export const makeInfoHandler: H.Handler<
  H.HttpRequest,
  H.HttpResponse<ApplicationInfo, 200>,
  undefined
> = H.of((_: H.HttpRequest) =>
  pipe(
    // TODO: Add all the function health checks
    [dummyHelthCheck] as ReadonlyArray<HealthCheckBuilder>,
    RA.sequence(applicativeValidation),
    RTE.map(() => H.successJson({ message: "it works!" })),
    RTE.mapLeft((problems) => new H.HttpError(problems.join("\n\n")))
  )
);

export const InfoFn = httpAzureFunction(makeInfoHandler);
