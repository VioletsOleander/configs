local com = vim.api.nvim_create_user_command

-- Display help vertically
com(
  "H",
  "vertical help <args>",
  { nargs = "*", complete = "help", desc = "Show help in vertical split window" }
)

-- Displayed diagnostic makes screen flicker when saving and formatting the file, therefore it
-- should be turned off in the most of the time
vim.diagnostic.config({
  signs = false,
  underline = false,
  virtual_lines = false,
  virtual_text = false,
})

-- Toggle diagnostic display
local show_diagnostic = false
com("ToggleDiagnostic", function()
  if show_diagnostic == false then
    vim.diagnostic.config({ signs = true, underline = true, virtual_lines = true })
    show_diagnostic = true
  else
    vim.diagnostic.config({
      signs = false,
      underline = false,
      virtual_lines = false,
      virtual_text = false,
    })
    show_diagnostic = false
  end
end, { desc = "Enable or disable showing attention attracting diagnostics" })

-- Toggle color column
com("ToggleColorColumn", function()
  if vim.wo.colorcolumn == "" then
    vim.wo.colorcolumn = "+1"
  else
    vim.wo.colorcolumn = ""
  end
end, { desc = "Enable or disable showing attention attracting colorcolumn" })

-- Toggle lsp inlay hint
com("ToggleLspInlayHint", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Enable or disable showing attention attracting lsp inlay hint." })
