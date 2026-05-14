if vim.g.vscode then
	return {}
elseif vim.g.user_use_builtin_completion then
	return {}
end

---@module "lazy"
---@module "blink.cmp"

---@type LazyPluginSpec
local copilot = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = { markdown = true },
	},
}

---@type blink.cmp.Config
local blink_opts = {
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-y>"] = { "select_and_accept", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-f>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
	},
	signature = { enabled = true, window = { show_documentation = true } },
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = false } },
	sources = {
		default = { "lsp", "copilot", "snippets", "buffer" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},
	fuzzy = { implementation = "rust" },
	cmdline = {
		enabled = false,
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
		},
		completion = {
			menu = { auto_show = true },
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
	},
}

---@type LazyPluginSpec
local blink_cmp = {
	"saghen/blink.cmp",
	event = { "InsertEnter" },
	build = function()
		require("blink.cmp").build():wait(60000)
	end,
	dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
	opts = blink_opts,
}

return { copilot, blink_cmp }
