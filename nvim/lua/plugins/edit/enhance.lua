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

return { nvim_surround, nvim_autopair }
