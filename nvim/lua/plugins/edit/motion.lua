if vim.g.vscode then
	return {}
end

---@module "lazy"
---@module "flash"

---@type LazyPluginSpec
local flash_nvim = {
	"folke/flash.nvim",
	event = "VeryLazy",
	config = function()
		local flash = require("flash")
		local map = vim.keymap.set

		map({ "n", "o", "x" }, "s", function()
			flash.jump()
		end, { desc = "jump to any visible position in current screen" })

		map({ "n", "o", "x" }, "gs", function()
			flash.treesitter()
		end, { desc = "jump to any syntax node in current screen" })

		map({ "o" }, "r", function()
			flash.remote()
		end, {
			desc = "perform any motion like jump, treesitter etc. "
				.. "the operator will be executed to the target position, "
				.. "and original position will be jumped back.",
		})

		map({ "o", "x" }, "R", function()
			flash.treesitter_search()
		end, { desc = "jump to the syntax node containing searched pattern in current screen" })

		---@type Flash.Config
		local opts = {
			highlight = {
				backdrop = false,
			},
			label = {
				uppercase = false,
			},
			modes = {
				char = {
					highlight = {
						backdrop = false,
					},
				},
			},
		}

		flash.setup(opts)
	end,
}

return { flash_nvim }
