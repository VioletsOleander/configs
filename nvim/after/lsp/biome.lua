---@type vim.lsp.Config
return {
	-- Remove json, jsonc, in order to not conflict with jsonls
	filetypes = {
		"astro",
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"svelte",
		"typescript",
		"typescriptreact",
		"vue",
	},
}
