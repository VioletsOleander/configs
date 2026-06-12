---@module "snacks"

local map = vim.keymap.set

-- Keymaps shared by VSCode and Neovim

-- Jump to line start/end
map({ "n", "x", "o" }, "H", "^", { desc = "Jump to line start" })
map({ "n", "x", "o" }, "L", "$", { desc = "Jump to line end" })

-- Jump to top/bottom of screen
map({ "n", "x", "o" }, "gh", "H", { desc = "Jump to top of screen" })
map({ "n", "x", "o" }, "gl", "L", { desc = "Jump to bottom of screen" })

-- Scroll 5 lines up/down
map({ "n", "x", "o" }, "<C-e>", "5<C-e>", { desc = "Jump 5 lines up" })
map({ "n", "x", "o" }, "<C-y>", "5<C-y>", { desc = "Jump 5 lines up" })

-- Copy/paste to system clipboard
map({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Clear screen
map("n", "<Leader>c", function()
  vim.cmd("nohlsearch")
  Snacks.notifier.hide()
  -- Close non-snacks related float windows
  -- (avoid closing leave the explorer)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)

    if config.relative ~= "" then
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

      if ft ~= "snacks_picker_list" and ft ~= "snacks_picker_input" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end
end, { desc = "Clear Screen (including search highlight, notifications, floating windows)" })

map("n", "zz", function()
  vim.cmd("normal! zz")
  vim.cmd("nohlsearch")
end, { desc = "Make cursor line in screen center and clear highlight" })
map("n", "zt", function()
  vim.cmd("normal! zt")
  vim.cmd("nohlsearch")
end, { desc = "Make cursor line in screen top and clear highlight" })
map("n", "zb", function()
  vim.cmd("normal! zb")
  vim.cmd("nohlsearch")
end, { desc = "Make cursor line in screen bottom and clear highlight" })

-- Insert mode to normal mode
-- Notice that in CTRL-X CTRL-L mode this will not work because vim does not allow this, which is kind of annoying
-- sometimes
map("i", "<C-l>", "<Esc>", { desc = "Switch to normal mode" })

-- Move between panes
map("n", "<C-h>", "<C-w>h", { desc = "Move to the left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to the right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to the down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to the up window" })

-- Switch between buffers
map("n", "<BS>", "<C-^>", { desc = "Switch to alternate file" })

-- Close
map("n", "<C-c>", "<Cmd>close<CR>", { desc = "Close current window" })

-- Quit
map("n", "<C-q>", "<Cmd>quit<CR>", { desc = "Quit current window" })
map("n", "<Leader>qq", "<Cmd>qall<CR>", { desc = "Exit Neovim" })

-- Save
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save File", silent = true })
map("n", "<Leader><CR>", "<Cmd>w<CR>", { desc = "Save File", silent = true })

-- Correct spell
map("i", "<C-a>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correc last spell using the first suggestion" })

--- Return the character after cursor
---
---@return string
local function get_next_char()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return line:sub(col + 1, col + 1)
end

--- Return true if the char after cursor is jumpable
--- Jumpable chars including: ] } " ' ` > ) ,
---
---@return boolean
local function next_is_jumpable()
  local chars = { ")", "]", "}", '"', "'", "`", ">", "," }
  local next_char = get_next_char()

  for _, char in ipairs(chars) do
    if next_char == char then
      return true
    end
  end

  return false
end

--- Return true if the completion menu is visible
---
---@return boolean
local function pum_is_visible()
  return vim.fn.pumvisible() ~= 0
end

-- Tab for accepting completion or jump out of brackets
map("i", "<Tab>", function()
  if pum_is_visible() then
    return "<C-y>"
  elseif next_is_jumpable() then
    return "<Right>"
  else
    return "<Tab>"
  end
end, { expr = true, desc = "Confirm completion or jump out of brackets" })

-- Tab/S-Tab for iterating completion items
map("c", "<Tab>", function()
  return pum_is_visible() and "<C-n>" or "<Tab>"
end, { expr = true, desc = "Select next completion item" })
map("c", "<S-Tab>", function()
  return pum_is_visible() and "<C-p>" or "<S-Tab>"
end, { expr = true, desc = "Select previous completion item" })

-- Ctrl-j/k for selecting completion items
map("i", "<C-j>", function()
  if pum_is_visible() then
    return "<C-n>"
  else
    return "<Down>"
  end
end, { expr = true, desc = "Select next completion or move current line down" })

map("i", "<C-k>", function()
  if pum_is_visible() then
    return "<C-p>"
  else
    return "<Up>"
  end
end, { expr = true, desc = "Select previous completion or move current line up" })

map("c", "<C-j>", function()
  if pum_is_visible() then
    return "<C-p>"
  else
    return "<C-j>"
  end
end, { expr = true, desc = "Select previous completion" })

map("c", "<C-k>", function()
  if pum_is_visible() then
    return "<C-p>"
  else
    return "<C-k>"
  end
end, { expr = true, desc = "Select previous completion" })

-- Exit terminal mode
map("t", [[<C-\><C-\>]], [[<C-\><C-n>]], { desc = "Exit terminal mode" })
