---@module "lazy"
---@module "markview"

---@type LazyPluginSpec
local treesitter_context = {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
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
  ---@type markview.config
  opts = {
    latex = {
      enable = false,
    },
    ---@diagnostic disable-next-line:missing-fields
    typst = {
      enable = false,
    },
  },
}

---@type LazyPluginSpec
local typst_preview = {
  "chomosuke/typst-preview.nvim",
  cmd = "TypstPreview",
}

return { treesitter_context, mini_icons, gitsigns, markview, typst_preview }
