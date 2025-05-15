/** @type {import('@yarnpkg/types')} */
const { defineConfig } = require("@yarnpkg/types");

/** @param {import('@yarnpkg/types').Yarn.Constraints.Workspace} w */
function setWorkspaceScripts(w) {
  w.set("scripts.format", "prettier --write .");
  w.set("scripts.format:check", "prettier --check .");
  w.set("scripts.lint", "eslint --fix src");
  w.set("scripts.lint:check", "eslint src");
  w.set("scripts.typecheck", "tsc --noEmit");
  w.set("scripts.test", "vitest run");
  w.set("scripts.test:coverage", "vitest run --coverage");
}

/** @param {import('@yarnpkg/types').Yarn.Constraints.Workspace} w */
function setDefaultWorkspaceType(w) {
  if (typeof w.manifest.type === "undefined") {
    w.set("type", "module");
  }
}

module.exports = defineConfig({
  async constraints({ Yarn }) {
    Yarn.workspaces()
      // Filter out the root workspace
      .filter((w) => w.cwd !== ".")
      .forEach((w) => {
        setWorkspaceScripts(w);
        setDefaultWorkspaceType(w);
      });
  },
});
