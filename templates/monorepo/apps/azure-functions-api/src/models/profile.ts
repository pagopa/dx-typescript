import * as t from "io-ts";

import { Container } from "@azure/cosmos";
import {
  CosmosdbModelVersioned,
  RetrievedVersionedModel
} from "@pagopa/io-functions-commons/dist/src/utils/cosmosdb_model_versioned";

import { wrapWithKind } from "@pagopa/io-functions-commons/dist/src/utils/types";

import { FiscalCode } from "../generated/definitions/models/FiscalCode";
import { EmailAddress } from "../generated/definitions/models/EmailAddress";

export const PROFILE_COLLECTION_NAME = "profiles";
export const PROFILE_MODEL_PK_FIELD = "fiscalCode" as const;

/**
 * Base interface for Profile objects
 */
export const Profile = t.intersection([
  t.interface({
    fiscalCode: FiscalCode
  }),
  t.partial({
    email: EmailAddress
  })
]);

export type Profile = t.TypeOf<typeof Profile>;

export const NewProfile = wrapWithKind(Profile, "INewProfile" as const);

export type NewProfile = t.TypeOf<typeof NewProfile>;

export const RetrievedProfile = wrapWithKind(
  t.intersection([Profile, RetrievedVersionedModel]),
  "IRetrievedProfile" as const
);

export type RetrievedProfile = t.TypeOf<typeof RetrievedProfile>;

/**
 * A model for handling Profiles
 */
export class ProfileModel extends CosmosdbModelVersioned<
  Profile,
  NewProfile,
  RetrievedProfile,
  typeof PROFILE_MODEL_PK_FIELD
> {
  /**
   * Creates a new Profile model
   *
   * @param dbClient the DocumentDB client
   * @param collectionUrl the collection URL
   */
  constructor(container: Container) {
    super(container, NewProfile, RetrievedProfile, "fiscalCode" as const);
  }
}
