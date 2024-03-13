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
    "parser": "@typescript-eslint/parser",
    "parserOptions": {
        "project": "tsconfig.json",
        "sourceType": "module"
    },
    "extends": [
        "@pagopa/eslint-config-node/index",
    ],
    "rules": {
        "@typescript-eslint/consistent-type-definitions": ["error", "type"]
    }
}
