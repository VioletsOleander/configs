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

-- Relative jump up/down
local function relative_jump_up()
  vim.wo.relativenumber = true

  vim.ui.input({ prompt = "Enter number of lines to jump up: ", scope = "cursor" }, function(input)
    local number = tonumber(input)

    if number then
      local cursor = vim.api.nvim_win_get_cursor(0)
      vim.api.nvim_win_set_cursor(0, { math.max(cursor[1] - number, 1), cursor[2] })
    else
      vim.notify("Invalid input, expect numbers")
    end

    vim.wo.relativenumber = false
  end)
end

local function relative_jump_down()
  vim.wo.relativenumber = true

  vim.ui.input(
    { prompt = "Enter number of lines to jump down: ", scope = "cursor" },
    function(input)
      -- Press Esc two times makes input == nil.
      if input ~= nil then
        local number = tonumber(input)

        if number then
          local cursor = vim.api.nvim_win_get_cursor(0)
          local line_count = vim.api.nvim_buf_line_count(0)
          vim.api.nvim_win_set_cursor(0, { math.min(cursor[1] + number, line_count), cursor[2] })
        else
          vim.notify("The input is invalid, please input valid numbers.")
        end
      end

      vim.wo.relativenumber = false
    end
  )
end

com("RelativeJumpUp", relative_jump_up, { desc = "Prompt user for a relative jump up." })
vim.keymap.set("n", "gk", relative_jump_up, { desc = "Prompt user for a relative jump up." })

com("RelativeJumpDown", relative_jump_down, { desc = "Prompt user for a relative jump down." })
vim.keymap.set("n", "gj", relative_jump_down, { desc = "Prompt user for a relative jump down." })
