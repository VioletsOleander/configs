-- Display diagnostic on the end of the line
vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.lsp.log_levels = vim.log.levels.WARN
