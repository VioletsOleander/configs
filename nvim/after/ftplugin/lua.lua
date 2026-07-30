vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 100

-- Do not autowrap, auto insert comment leader
vim.opt_local.formatoptions:remove({ "t", "c", "r", "o" })
