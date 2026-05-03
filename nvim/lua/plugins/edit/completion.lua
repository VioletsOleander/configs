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
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-f>"] = { "show", "show_documentation", "fallback" },
	},
	signature = { enabled = true, window = { show_documentation = true } },
	cmdline = { enabled = false },
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "copilot", "path", "snippets", "buffer" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
}

---@type LazyPluginSpec
local blink_cmp = {
	"saghen/blink.cmp",
	event = { "InsertEnter" },
	dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
	version = "1.*",
	opts = blink_opts,
	opts_extend = { "sources.default" },
}

return { copilot, blink_cmp }
