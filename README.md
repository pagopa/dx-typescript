# TypeScript Monorepo Template

Scaffold a new project using a monorepo structure.
Each monorepo is meant to include all the published artifacts for the project as well as the infrastructure definition.

## Getting Started

### Using Devcontainer

The preferred way to setup your development environment is to use [Devcontainer](https://containers.dev) ([Host system requirements](https://code.visualstudio.com/docs/devcontainers/containers#_system-requirements)).

> [!TIP]
> If you are on macOS we recommend using [Rancher Desktop](https://rancherdesktop.io/) configured to use `VZ` as _Virtual Machine Type_ and `virtiofs` as volume _Mount Type_.

#### Visual Studio Code

1. Make sure `docker` is available and running in your host system
2. Install the [Devcontainer Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
3. Open the project root folder and select `Dev Containers: Reopen in Container` from the command palette
4. Visual Studio Code will build the devcontainer image and then open the project inside the container, with all the needed tools and extension configured

#### Console

If you use a code editor that doesn't support Dev Container, you can still run it in your terminal.

1. Follow the instruction of the following chapter ("Using local machine") to setup your local environment
2. Run devcontainer from your terminal
   ```bash
   yarn devcontainer up --workspace-folder .
   yarn devcontainer exec -- workspace-folder . /bin/bash
   ```

### Using local machine

This project use specific versions of `node`, `yarn` and `terraform`. To make sure your development setup matches with production follow the recommended installation methods.

1. Install and configure the following tools in your machine

   - [nodenv](https://github.com/nodenv/nodenv) - Node version manager
   - [tfenv](https://github.com/tfutils/tfenv) - Terraform version manager
   - [terraform-docs](https://terraform-docs.io/user-guide/installation/) - Generate Terraform modules documentation in various formats
   - [tflint](https://github.com/terraform-linters/tflint) - A Pluggable Terraform Linter
   - [pre-commit](https://pre-commit.com/) - A framework for managing and maintaining multi-language pre-commit hooks

2. Install `node` at the right version used by this project

   ```bash
    cd path/to/io-messages
    nodenv install
   ```

3. Install `yarn` using [corepack](https://nodejs.org/api/corepack.html) (Node Package Manager version manager, it is distributed with `node`). This step will also install all the required dependencies

> [!IMPORTANT]
> Yarn uses Plug and Play for dependency management. For more information, see: [Yarn Plug’n’Play](https://yarnpkg.com/features/pnp)

   ```bash
   corepack enable
   yarn
   ```

4. Build all the workspaces contained by this repo
   ```bash
   yarn build
   ```

## Release management

We use [changesets](https://github.com/changesets/changesets) to automate package versioning and releases.

Each Pull Request that includes changes that require a version bump must include a _changeset file_ that describes the introduced changes.

To create a _changeset file_ run the following command and follow the instructions.

```bash
yarn changeset
```

## Useful commands

This project uses `yarn` and `turbo` with workspaces to manage projects and dependencies. Here is a list of useful commands to work in this repo.

### Work with workspaces

```bash
# build all the workspaces using turbo
yarn build
# or
yarn turbo build

# to execute COMMAND on WORKSPACE_NAME
yarn workspace WORKSPACE_NAME run command
# to execute COMMAND on all workspaces
yarn workspace foreach run command

# run unit tests on citizen-func
yarn workspace citizen-func run test
# or (with turbo)
yarn turbo test -- citizen-func

# run the typecheck script on all workspaces
yarn workspaces foreach run typecheck
```

### Add dependencies

```bash
# add a dependency to the workspace root
yarn add turbo

# add vitest as devDependency on citizen-func
yarn workspace citizen-func add -D vitest

# add zod as dependency on each workspace
yarn workspace foreach add zod
```

## Folder structure

### `/apps`

It contains the applications included in the project.
Each folder is meant to produce a deployable artifact; how and where to deploy it is demanded to a single application.

Each sub-folder is a workspace.

### `/packages`

Packages are reusable TypeScript modules that implement a specific logic of the project. They are meant for sharing implementations across other apps and packages of the same projects, as well as being published in public registries.

Packages that are meant for internal code sharing have `private: true` in their `package.json` file; all the others are meant to be published into the public registry.

Each sub-folder is a workspace.

### `/infra`

It contains the _infrastructure-as-code_ project that defines the resources for the project as well as the executuion environments. Database schemas and migrations are defined here too, in case they are needed.

### `/docs`

Technical documentation about the project. Topics that may be included are architecture overviews, [ADRs](https://adr.github.io/), coding standards, and anything that can be relevant for a developer approaching the project as a contributor or as an auditor.

User documentation doesn't usually go in here. For public packages, it must go in the package's `README` file so that it will also be uploaded to the registry; user-faced documentation websites, when needed by the project, go under the `/apps` folder as they are treated as end-user applications.

## Releases

Releases are handled using [Changeset](https://github.com/changesets/changesets).
Changeset takes care of bumping packages, updating the changelog, and tag the repository accordingly.

#### How it works

- When opening a Pull Request with a change intended to be published, [add a changeset file](https://github.com/changesets/changesets/blob/main/docs/adding-a-changeset.md) to the proposed changes.
- Once the Pull Request is merged, a new Pull Request named `Version Packages` will be automatically opened with all the release changes such as version bumping for each involved app or package and changelog update; if an open `Version Packages` PR already exists, it will be updated and the package versions calculated accordingly (see https://github.com/changesets/changesets/blob/main/docs/decisions.md#how-changesets-are-combined).
  Only apps and packages mentioned in the changeset files will be bumped.
- Review the `Version Packages` PR and merge it when ready. Changeset files will be deleted.
- A Release entry is created for each app or package whose version has been bumped.

## Infrastructure as Code

### Folder structure

The IaC template contains the following projects:

#### identity

Handle the identity federation between GitHub and Azure. The identity defines the grants the GitHub Workflows have on the Azure subscription.
Configurations are intended for the pair (environment, region); each configuration is a Terraform project in the folder `infra/identity/<env>/<region>`
It's intended to be executed once on a local machine at project initialization.

⚠️ The following edits have to be done to work on the repository:

- Define the project in the right env/region folder.
- Edit `locals.tf` according to the intended configuration.
- Edit `main.tf` with the actual Terraform state file location and name.

```sh
# Substitute env and region with actual values
cd infra/identity/<env>/<region>

# Substitute subscription_name with the actual subscription name
az account set --name <subscription_name>

terraform init
terraform plan
terraform apply
```

#### repository

Set up the current repository settings.
It's intended to be executed once on a local machine at project initialization.

⚠️ The following edits have to be done to work on the repository:

- Edit `locals.tf` according to the intended configuration.
- Edit `main.tf` with the actual Terraform state file location and name.

```sh
cd infra/repository

# Substitute subscription_name with the actual subscription name
az account set --name <subscription_name>

terraform init
terraform plan
terraform apply
```

#### resources

Contains the actual resources for the developed applications.
Configurations are intended for the pair (environment, region); each configuration is a Terraform project in the folder `infra/resources/<env>/<region>`

⚠️ The following edits have to be done to work on the repository:

- Edit `locals.tf` according to the intended configuration.
- Edit `main.tf` with the actual Terraform state file location and name.

### Workflow automation

The workflow `pr_infra.yaml` is executed on every PR that edits the `infra/resources` folder or the workflow definition itself. It executes a `terraform plan` and comments the PR with the result. If the plan fails, the workflow fails.
