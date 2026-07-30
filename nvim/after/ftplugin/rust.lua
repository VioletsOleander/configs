vim.treesitter.start()

vim.opt_local.textwidth = 100

-- Do not autowrap, auto insert comment leader
vim.opt_local.formatoptions:remove({ "t", "c", "r", "o" })
