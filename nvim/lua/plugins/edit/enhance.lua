---@module "lazy"

---@type LazyPluginSpec
local nvim_surround = {
  "kylechui/nvim-surround",
  event = "VeryLazy",
}

---@type LazyPluginSpec
local nvim_autopair = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
  },
}

return { nvim_surround, nvim_autopair }
