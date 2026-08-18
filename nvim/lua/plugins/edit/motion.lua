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
    end, { desc = "Jump to visible position by searching" })

    map({ "n", "o", "x" }, "gs", function()
      flash.treesitter()
    end, { desc = "Select visible parent treesitter node" })

    map("o", "r", function()
      flash.remote()
    end, {
      desc = "Jump to visible potisoin by searching and enter operator pending mode. Jump back after finishing operator",
    })

    map({ "o", "x" }, "R", function()
      flash.treesitter_search()
    end, { desc = "Select range by searching neighboring treesitter node" })

    ---@type Flash.Config
    local opts = {
      search = {
        -- The cursor will flick when search multi_window, so disable it
        multi_window = false,
        exclude = {
          "snacks_picker_input",
          "flash_prompt",
          function(win)
            return not vim.api.nvim_win_get_config(win).focusable
          end,
        },
      },
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
          char_actions = function()
            return {
              [";"] = "right",
              [","] = "left",
            }
          end,
        },
        treesitter = {
          jump = { autojump = false },
        },
      },
    }

    flash.setup(opts)
  end,
}

return { flash_nvim }
