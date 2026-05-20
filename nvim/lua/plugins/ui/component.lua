if vim.g.vscode then
	return {}
end

---@module "lazy"

---@type LazyPluginSpec
local treesitter_context = {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {},
}

---@type LazyPluginSpec
local mini_icons = {
	"nvim-mini/mini.icons",
	event = "VeryLazy",
	opts = {},
}

---@type LazyPluginSpec
local gitsigns = {
	"lewis6991/gitsigns.nvim",
	cmd = "Gitsigns",
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
	},
}

---@type LazyPluginSpec
local markview = {
	"OXY2DEV/markview.nvim",
	cmd = "Markview",
}

return { treesitter_context, mini_icons, gitsigns, markview }
