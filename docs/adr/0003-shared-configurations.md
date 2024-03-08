# 1. We want workspaces of a monorepo to use the same configurations

Date: 2024-03-08

## Status

Accepted

## Context
Each workspace in a monorepo needs to configure to use things such as TypeScript and ESLint. 

## Decision

We provide centralized configuration files that workspaces are encouraged to refer to, to share the same configuration, and to promote compatibility and code reuse.

Granularity is both for subject and workspace kind. For example: `typescript-config-node`, `typescript-config-react`, `eslint-config-node`, etc.

Each configuration is a workspace under the `/configs` folder; workspaces will reference them accordingly.

We won't support different versions per kind. In the example above, we have `typescript-config-node` and we DO NOT HAVE ``typescript-config-node20`, `typescript-config-node16`, `typescript-config-node-variant`, etc.


## Consequences

By having a centralized configuration we achieve homogeneity in code across workspaces.

By supporting only one version at a time we force users to keep their codebase updated.

By each configuration being a workspace on its own we have projects to only have configurations that are relevant to them.
