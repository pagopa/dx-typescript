module.exports = {
    "ignorePatterns": [
        "node_modules",
        "src/generated",
        "**/__tests__/*",
        "**/__mocks__/*",
        "*.d.ts",
        "docker",
        "jest.config.js",
        "**/__integrations__/*",
    ],
    "extends": [
        "@repo/eslint-config-node",
    ],
    "rules": {
        "@typescript-eslint/consistent-type-definitions": ["error", "type"]
    }
}
