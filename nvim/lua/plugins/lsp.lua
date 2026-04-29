if vim.g.vscode then
	return {}
end

---@module "lazy"

---@type LazyPluginSpec
local lsp_config = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.lsp.enable({ "lua_ls", "stylua", "ty", "ruff", "yamlls", "jsonls", "rust_analyzer" })
	end,
}

---@type LazyPluginSpec
local conform = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			yaml = { "prettier" },
			json = { "prettier" },
			toml = { "taplo" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 3000,
		},
	},
}

return { lsp_config, conform }
