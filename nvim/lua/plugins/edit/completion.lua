---@module "lazy"
---@module "blink.cmp"

---@type blink.cmp.Config
local blink_opts = {
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-f>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
  },
  signature = { enabled = false, window = { show_documentation = true } },
  completion = {
    list = {
      selection = {
        auto_insert = false,
      },
    },
    accept = {
      dot_repeat = false,
      auto_brackets = {
        enabled = false,
      },
    },
    documentation = { auto_show = false },
  },
  sources = { default = { "lsp", "snippets", "buffer" } },
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
  version = "*",
  event = { "InsertEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = blink_opts,
}

return { blink_cmp }
