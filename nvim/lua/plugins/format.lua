---@module "lazy"
---@module "conform"

---@type LazyPluginSpec
local conform = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      python = { "ruff_format", "ruff_organize_imports" },
      toml = { "dprint" },
      markdown = { "dprint" },
      typescript = { "dprint" },
      javascript = { "dprint" },
      yaml = { "dprint" },
      json = { "dprint" },
      jsonc = { "dprint" },
      svelte = { "dprint" },
      nu = { "nufmt" },
      tex = { "tex-fmt" },
      typst = { "typstyle" },
    },
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { lsp_format = "fallback", timeout_ms = 3000 }
    end,
  },
}

return { conform }
