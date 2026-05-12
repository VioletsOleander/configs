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
			-- Typescript
			"vtsls",
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
			python = { "ruff_format", "ruff_organize_imports" },
			yaml = { "prettier" },
			json = { "prettier" },
			toml = { "taplo" },
			markdown = { "dprint" },
			rust = { "rustfmt" },
			typescript = { "oxfmt" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 3000,
		},
	},
}

return { lsp_config, conform }
