local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

-- Hold autocmds related with buffer/lsp/other(unclassified)
local buf_group = aug("user.buf", { clear = true })
local lsp_group = aug("user.lsp", { clear = true })
local other_group = aug("user.other", { clear = true })

-- Readonly files
au("BufRead", {
  group = buf_group,
  pattern = { "*/.rustup/*", "*/.cargo/*", "*/.venv/*", "*/node_modules/*", "*/.lua_modules/*" },
  callback = function()
    vim.opt_local.readonly = true
    vim.opt_local.modifiable = false
  end,
})

-- Autosave
au("BufWritePre", {
  group = buf_group,
  callback = function()
    if not vim.api.nvim_buf_is_valid(0) or not vim.bo.buftype == "" then
      return
    end
    -- Not editable buffer
    if not vim.bo.modifiable or vim.bo.readonly then
      return
    end

    if not vim.g.disable_autoformat then
      require("conform").format({ lsp_format = "fallback", timeout_ms = 3000 })
    end
  end,
})

-- Lsp keymaps
au("LspAttach", {
  group = lsp_group,
  pattern = "*",
  callback = function(ev)
    --- Help function to set buffer local keymap
    ---
    ---@param modes string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
    ---@param lhs string Left-hand side |{lhs}| of the mapping.
    ---@param rhs string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
    ---@param desc string Description
    local function map_local(modes, lhs, rhs, desc)
      vim.keymap.set(modes, lhs, rhs, { buf = ev.buf, desc = desc })
    end

    -- Lsp gotos
    map_local("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map_local("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map_local("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
    map_local("n", "gI", vim.lsp.buf.implementation, "Go to implementation")

    -- LSP shows
    -- Special case: do not wait the builtin gr* keymaps
    vim.keymap.set(
      "n",
      "gr",
      vim.lsp.buf.references,
      { buf = ev.buf, nowait = true, desc = "Show references" }
    )

    map_local("n", "ga", vim.diagnostic.open_float, "Show diagnostics")
    map_local("n", "gA", function()
      vim.diagnostic.open_float({ close_events = { "BufHidden" } })
    end, "Show persist diagnostic (requires manual close)")

    -- LSP actions
    map_local("n", "<Leader>r", vim.lsp.buf.rename, "Rename symbol")

    map_local("n", "<Leader>a", vim.lsp.buf.code_action, "Code action")
  end,
})

-- Cmdline autocompletion (blink's cmdline completion does not support :s/old/new)
-- (but the builin completion feels more laggy comapred to blink when complete :!, :checkhealth)
au("CmdlineChanged", {
  group = other_group,
  pattern = { ":", "/", "?" },
  callback = function()
    local cmd = vim.fn.getcmdline()

    -- Avoid stuck on completing binary executables
    if vim.startswith(cmd, "!") then
      return
    else
      vim.fn.wildtrigger()
    end
  end,
  desc = "Automatically show popup menu when typing in cmd line",
})
