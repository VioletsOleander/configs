if vim.g.vscode then
	return {}
end

---@module "lazy"

---@alias colortheme
---| '"everforest"'
---| '"gruvbox-material"'
---| '"edge"'
---| '"tokyonight-day"'
---| '"dayfox"'
---| '"onelight"'

---@type colortheme
local current_theme = "gruvbox-material"

---@type LazyPluginSpec
local gruvbox = {
	"sainnhe/gruvbox-material",
	lazy = (current_theme ~= "gruvbox-material"),
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_background = "medium"
		vim.cmd("colorscheme gruvbox-material")
	end,
}

---@type LazyPluginSpec
local everforest = {
	"sainnhe/everforest",
	lazy = (current_theme ~= "everforest"),
	priority = 1000,
	config = function()
		vim.g.everforest_better_performance = 1
		vim.g.everforest_background = "medium"
		vim.cmd("colorscheme everforest")
	end,
}

---@type LazyPluginSpec
local edge = {
	"sainnhe/edge",
	lazy = (current_theme ~= "edge"),
	priority = 1000,
	config = function()
		vim.g.edge_better_performance = 1
		vim.cmd("colorscheme edge")
	end,
}

---@type LazyPluginSpec
local tokyonight_day = {
	"folke/tokyonight.nvim",
	lazy = (current_theme ~= "tokyonight-day"),
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			styles = {
				comment = { italic = false },
				keywords = { italic = false },
			},
		})
		vim.cmd("colorscheme tokyonight-day")
	end,
}

---@type LazyPluginSpec
local dayfox = {
	"EdenEast/nightfox.nvim",
	lazy = (current_theme ~= "dayfox"),
	priority = 1000,
	config = function()
		require("nightfox").setup()
		vim.cmd("colorscheme dayfox")
	end,
}

---@type LazyPluginSpec
local onelight = {
	"navarasu/onedark.nvim",
	lazy = (current_theme ~= "onelight"),
	priority = 1000,
	config = function()
		local colors = {
			bg_blue = "#4078f2",
			purple = "#950095",
			green = "#327a2e",
			orange = "#bc6b0b",
			blue = "#426ce8",
			cyan = "#2e7a78",
			red = "#be342c",
		}
		local highlights = {
			ModeMsg = { fg = "$black" },
		}

		local opts = {
			style = "light",
			toggle_style_list = { "light" },
			highlights = highlights,
			colors = colors,
		}

		require("onedark").setup(opts)
		require("onedark").load()
	end,
}

return { gruvbox, everforest, edge, tokyonight_day, dayfox, onelight }
