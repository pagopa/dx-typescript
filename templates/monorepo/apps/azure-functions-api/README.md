# Azure Function Template

This Workspace is a template to implement an Azure Function for simple REST API.

## Architecture

The project is structured as follows:

```
azure-functions-api
|-- api
|-- docker
|-- Info
|   |-- function.json
|-- src
|   |-- functions
|   |-- generated
|   |-- middlewares
|   |-- utils
|   |   |-- cosmos
|   |   |-- redis
|   |-- config.ts
|   |-- main.ts
|-- package.json
|-- docker-compose.yaml
|-- host.json
```

- The `api` folder contains all the internal and external OpenAPI specification.
- The `Info` folder is the Azure function configuration containing only the `function.json` file.
- The `src` folder contain all the implementation of the functions

### src Folder

The `src` folder contains the `main.ts` file that exports the implementation for all the functions defined in this repo. Any function link to this file selecting the specific implementation using the `entryPoint` prop:

function.json
```json
{
  "bindings": [
    {
      ...
    },
    {
      "type": "http",
      "direction": "out",
      "name": "$return"
    }
  ],
  "scriptFile": "../dist/main.js",
  "entryPoint": "Info"
}
```

## ENV variables

The following table contains the required ENV variables that the applicative require

| Variable name                      | Description                                  | type    |
|------------------------------------|----------------------------------------------|---------|
| APPINSIGHTS_INSTRUMENTATIONKEY     | The Application Insights instrumentation key | string  |
| COSMOS_CONNECTION_STRING           | citizen-auth Cosmos Connection String        | string  |
| COSMOS_DB_NAME                     | citizen-auth Cosmos DB name                  | string  |
| FETCH_TIMEOUT_MS                   | (optional) Fetch Timeout for AbortableFetch  | number  |
| REDIS_URL                          | The url of the redis service                 | string  |
| REDIS_PASSWORD                     | (Optional) The password for the redis service| string  |
| REDIS_PORT                         | (Optional)The port for the redis service     | string  |
| REDIS_TLS_ENABLED                  | Use a TLS connection to the redis service    | boolean |

## Local Execution

not yet included

[//]: <> (To execute locally the function copy the configuration from the `env.example` file with:)

[//]: <> (```bash)
[//]: <> (cp env.enxample .env)
[//]: <> (```)

[//]: <> (Then you can start the docker compose to execute the function environment)
[//]: <> (```bash)
[//]: <> (docker compose up --build -d)
[//]: <> (```)

## Integration test

not yet included

### Testing models

not yet included

