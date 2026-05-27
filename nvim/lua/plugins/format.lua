if vim.g.vscode then
	return {}
end

---@module "lazy"
---@module "conform"

---@type LazyPluginSpec
local conform = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "ruff_format", "ruff_organize_imports" },
			toml = { "dprint" },
			markdown = { "dprint" },
			typescript = { "dprint" },
			javascript = { "dprint" },
			yaml = { "dprint" },
			json = { "dprint" },
			jsonc = { "dprint" },
			svelte = { "dprint" },
			nu = { "nufmt" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 3000,
		},
	},
}

return { conform }
