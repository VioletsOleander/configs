-- Directly return if current buffer is for floating window
if vim.bo.buftype == "nofile" then
  return
end

vim.treesitter.start()

vim.opt_local.textwidth = 100
vim.opt_local.colorcolumn = "+1"
vim.opt_local.spell = true
vim.opt_local.autocomplete = false
vim.opt_local.completeopt = "menu,popup"

vim.b.completion = false
