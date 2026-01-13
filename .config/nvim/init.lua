require("config.lazy")

-- n-v-c: Normal, Visual, Command-line Normal mode use block
-- i-ci-ve: Insert, Command-line Insert, Visual-exclude mode use ver25 (vertical bar)
-- r-cr: Replace, Command-line Replace mode use block
-- o: Operator-pending mode use hor20 (horizontal bar)
-- blinkon0: Disable blinking
vim.opt.guicursor = {
    "n-v-c:block-blinkon0",
    "i-ci-ve:ver25-blinkon0",
    "r-cr:block-blinkon0",
    "o:hor20-blinkon0",
}

-- reset cursor when exit
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    callback = function()
        vim.opt.guicursor = ""
        vim.fn.chansend(vim.v.stderr, "\x1b[0 q")
    end,
})

-- tab use 4 spaces
-- (auto)indent use 4 spaces
-- backspace use 4 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- insert mode to normal mode keymaps
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kk', '<Esc>')
vim.keymap.set('i', '<A-n>', 'HELLO')
