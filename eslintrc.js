/* Minimal eslint that basically just checks parsing.
 * JavaScript projects should override with a local version.
 */
module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  overrides: [],
  parserOptions: {
    ecmaVersion: "latest",
  },
  rules: {},
};
