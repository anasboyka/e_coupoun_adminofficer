module.exports = {
	root: true,
	env: {
		es6: true,
		node: true,
	},
	extends: [
		"eslint:recommended",
		"plugin:import/errors",
		"plugin:import/warnings",
		"plugin:import/typescript",
		"google",
		"plugin:@typescript-eslint/recommended",
	],
	parser: "@typescript-eslint/parser",
	parserOptions: {
		project: ["tsconfig.json", "tsconfig.dev.json"],
		sourceType: "module",
	},
	ignorePatterns: [
		"/lib/**/*", // Ignore built files.
	],
	plugins: [
		"@typescript-eslint",
		"import",
	],
	rules: {
		"max-len": ["error", {"code": 120}],
		"indent": [2, "tab"],
		"no-tabs": 0,
		"quotes": ["error", "double"],
		"import/no-unresolved": 0,
		"eol-last": 0,
		"no-multiple-empty-lines": ["error", {"max": 9999, "maxEOF": 0}],
	},
};
