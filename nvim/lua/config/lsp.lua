-- Display diagnostic on the end of the line
vim.diagnostic.config({ virtual_text = true, severity_sort = true })

-- Disable spell check, colorcolumn for lsp float window
local _open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	local bufnr, winnr = _open_floating_preview(contents, syntax, opts)
	if vim.api.nvim_win_is_valid(winnr) then
		vim.api.nvim_set_option_value("spell", false, { scope = "local", win = winnr })
		vim.api.nvim_set_option_value("colorcolumn", "", { scope = "local", win = winnr })
	end
	return bufnr, winnr
end

vim.lsp.log_levels = vim.log.levels.WARN
