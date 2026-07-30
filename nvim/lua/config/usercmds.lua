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
    vim.diagnostic.config({ signs = true, underline = true })
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
local show_colorcolumn = false
com("ToggleColorColumn", function()
  if show_colorcolumn == false then
    vim.opt_local.colorcolumn = "+1"
    show_colorcolumn = true
  else
    vim.opt_local.colorcolumn = ""
    show_colorcolumn = false
  end
end, { desc = "Enable or disable showing attention attracting colorcolumn" })
