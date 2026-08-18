-- If an action is intended to be either triggered by command and keymap,
-- then define the action here. If an action is intended to be only triggered
-- by keymap (using command will be cumbersome), then define the action in `keymap.lua`.
local com = vim.api.nvim_create_user_command

-- Display help vertically.
com(
  "H",
  "vertical help <args>",
  { nargs = "*", complete = "help", desc = "Show help in vertical split window" }
)

-- Displayed diagnostic makes screen flicker when saving and formatting the file, therefore it
-- should be turned off in the most of the time.
vim.diagnostic.config({
  signs = false,
  underline = false,
  virtual_lines = false,
  virtual_text = false,
})

-- Toggle diagnostic display.
local show_diagnostic = false
com("ToggleDiagnostic", function()
  if show_diagnostic == false then
    vim.diagnostic.config({ signs = true, underline = true, virtual_lines = true })
    vim.diagnostic.show()
    show_diagnostic = true
  else
    vim.diagnostic.hide()
    vim.diagnostic.config({
      signs = false,
      underline = false,
      virtual_lines = false,
      virtual_text = false,
    })
    show_diagnostic = false
  end
end, { desc = "Enable or disable showing attention attracting diagnostics" })

-- Toggle color column.
com("ToggleColorColumn", function()
  if vim.wo.colorcolumn == "" then
    vim.wo.colorcolumn = "+1"
  else
    vim.wo.colorcolumn = ""
  end
end, { desc = "Enable or disable showing attention attracting colorcolumn" })

-- Toggle lsp inlay hint.
com("ToggleLspInlayHint", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Enable or disable showing attention attracting lsp inlay hint." })

-- Toggle relative number
local function toggle_relative_number()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = false
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
  end
end

com(
  "ToggleRelativeNumber",
  toggle_relative_number,
  { desc = "Enable or disable showing attention attracting relativenumber." }
)

vim.keymap.set(
  "n",
  "<C-n>",
  toggle_relative_number,
  { desc = "Enable or disable showing attention attracting relativenumber." }
)

-- Format current buffer.
local function format_and_save()
  if not vim.api.nvim_buf_is_valid(0) or not vim.bo.buftype == "" then
    return
  end
  -- Not editable buffer
  if not vim.bo.modifiable or vim.bo.readonly then
    return
  end

  if not vim.g.disable_autoformat then
    require("conform").format({ lsp_format = "fallback", timeout_ms = 3000 })
  end

  vim.cmd("update")
end

com(
  "FormatBuffer",
  format_and_save,
  { desc = "Format current buffer with preconfigured formatter and save it." }
)

vim.keymap.set("n", "<Leader>w", format_and_save, { desc = "Format and save file" })
vim.keymap.set("n", "<Leader><CR>", format_and_save, { desc = "Format and save file" })
