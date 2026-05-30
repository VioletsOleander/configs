---@module "lazy"

---@type LazyPluginSpec
local nvim_surround = {
	"kylechui/nvim-surround",
	event = "VeryLazy",
}

---@type LazyPluginSpec
local nvim_autopair = {
	"windwp/nvim-autopairs",
	cond = not vim.g.vscode,
	event = "InsertEnter",
	opts = {},
}

---@type LazyPluginSpec
local vimtex = {
	"lervag/vimtex",
	cond = not vim.g.vscode,
	ft = "tex", -- Lazy loading will break inverse search, but not a big problem for me
	config = function()
		vim.g.vimtex_complete_enabled = 0
		vim.g.vimtex_quickfix_enabled = 0
		vim.g.vimtex_mappings_enabled = 0

		vim.g.vimtex_view_automatic = 0
		vim.g.vimtex_syntax_conceal_disable = 1

		vim.g.vimtex_compiler_latexmk = { aux_dir = "build", out_dir = "build" }
	end,
}

return { nvim_surround, nvim_autopair, vimtex }
