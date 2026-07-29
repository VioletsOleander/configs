-- Display help vertically
vim.api.nvim_create_user_command(
  "H",
  "vertical help <args>",
  { nargs = "*", complete = "help", desc = "Show help in vertical split window" }
)

-- Displayed diagnostic makes screen flicker when saving and formatting the file, therefore it should be turned off in
-- most of the time
vim.diagnostic.config({ signs = false, underline = false, virtual_lines = false, virtual_text = false })

-- Toggle diagnostic display
local show_diagnostic = false
vim.api.nvim_create_user_command("ToggleDiagnostic", function()
  if show_diagnostic == false then
    vim.diagnostic.config({ signs = true, underline = true })
    show_diagnostic = true
  else
    vim.diagnostic.config({ signs = false, underline = false, virtual_lines = false, virtual_text = false })
    show_diagnostic = false
  end
end, { desc = "Enable or disable showing attention attracting diagnostics" })

-- Experimental features
-- UI2 (flicker in wildtrigger, disable now)
-- require("vim._core.ui2").enable({ enable = true })
-- vim.opt.cmdheight = 0

-- WSL
-- Refers to: https://vi.stackexchange.com/questions/42305/neovim-following-the-instructions-in-h-clipboard-wsl-not-work-it-shows-no
if vim.fn.has("wsl") then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = true,
  }
end
