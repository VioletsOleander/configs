if vim.g.vscode then
	return {}
end

---@module "lazy"
---@module "conform"

---@type LazyPluginSpec
local lsp_config = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.lsp.enable({
			-- Lua
			"lua_ls",
			"stylua",
			-- Python
			"ty",
			"ruff",
			-- Json
			"jsonls",
			-- Yaml
			"yamlls",
			-- Rust
			"rust_analyzer",
			-- Typescript, HTML, CSS, Svelte
			"vtsls",
			"html",
			"cssls",
			"svelte",
			"oxlint",
		})
	end,
}

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
			yaml = { "dprint" },
			json = { "dprint" },
			jsonc = { "dprint" },
			svelte = { "dprint" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 3000,
		},
	},
}

return { lsp_config, conform }
