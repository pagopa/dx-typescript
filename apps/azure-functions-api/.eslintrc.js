const { resolve } = require("node:path");
const currentDirectory =  process.cwd();
const project = currentDirectory.includes("apps/azure-functions-api") ? resolve(process.cwd(), "tsconfig.json") : resolve(process.cwd(), "apps/azure-functions-api/tsconfig.json");
module.exports = {
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "ignorePatterns": [
    "node_modules",
    "src/generated",
    "*.d.ts",
    "jest.config.js"
  ],
  root: true,
  "parser": "@typescript-eslint/parser",
  "parserOptions": { "project": [project] },
  "extends": [
    "@pagopa/eslint-config-node/index",
  ],
  "rules": {
    "no-unused-vars": "off",
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_",
        "varsIgnorePattern": "^_",
        "caughtErrorsIgnorePattern": "^_"
      }
    ]
  }
}
