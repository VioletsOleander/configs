-- Display diagnostic on the end of the line
vim.diagnostic.config({ virtual_text = true, severity_sort = true })
-- Lsp log level
vim.lsp.log_levels = vim.log.levels.WARN

-- Display help vertically
vim.api.nvim_create_user_command("H", "vertical help <args>", { nargs = "*", complete = "help" })

-- Experimental features
-- UI2 (flicker in wildtrigger, disable now)
-- require("vim._core.ui2").enable({ enable = true })
-- vim.opt.cmdheight = 0
