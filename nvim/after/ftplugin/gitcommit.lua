vim.treesitter.start()

vim.opt_local.textwidth = 100
-- Do not autowrap, auto insert comment leader
vim.opt_local.formatoptions:remove({ "t", "c", "r", "o" })

vim.opt_local.spell = true
vim.opt_local.completeopt = "menu,popup"

vim.b.completion = false
