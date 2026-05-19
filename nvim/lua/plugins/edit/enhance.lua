---@module "lazy"

---@type LazyPluginSpec
local nvim_surround = {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
}

---@type LazyPluginSpec
local nvim_autopair = {
	"windwp/nvim-autopairs",
	cond = not vim.g.vscode,
	event = "InsertEnter",
	opts = {},
}

---@type LazyPluginSpec
local nvim_ts_autotag = {
	"windwp/nvim-ts-autotag",
	cond = not vim.g.vscode,
	ft = { "svelte", "html" },
	opts = {},
}

return { nvim_surround, nvim_autopair, nvim_ts_autotag }
