if vim.g.vscode then
  return nil
end

local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

-- Hold autocmds done by native functions
local native_group = aug("user.native", { clear = true })
-- Hold autocmds done by lsp-related functions
local lsp_group = aug("user.lsp", { clear = true })

if vim.g.user_use_builtin_completion then
  -- Lsp autocompletion
  au("LspAttach", {
    group = lsp_group,
    pattern = "*",
    callback = function(ev)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
      if not client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end,
  })
else
  -- Cmdline autocompletion (blink's cmdline completion does not support :s/old/new)
  -- (but the builin completion feels more laggy comapred to blink when complete :!, :checkhealth)
  au("CmdlineChanged", {
    group = native_group,
    pattern = { ":", "/", "?" },
    callback = function()
      vim.fn.wildtrigger()
    end,
    desc = "Automatically show popup menu when typing in cmd line",
  })
end

local treesitter_fts = {
  -- Program
  "lua",
  "python",
  "rust",
  "typescript",
  "javascript",
  -- Markup
  "html",
  "css",
  "svelte",
  "markdown",
  "tex",
  -- Configuration
  "json",
  "jsonc",
  "toml",
  "yaml",
  "vim",
  -- Shell
  "bash",
  "nu",
  -- Other
  "gitcommit",
  "gitignore",
  "help",
}

-- Enable treesitter highlight
au("FileType", {
  group = native_group,
  pattern = treesitter_fts,
  callback = function()
    vim.treesitter.start()
  end,
})

-- Help
au("BufWinEnter", {
  group = native_group,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd("wincmd L")
    end
  end,
  desc = "Show help in vertical split window",
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
    map_local("n", "gi", vim.lsp.buf.implementation, "Go to implementation")

    -- LSP shows
    map_local("n", "gr", vim.lsp.buf.references, "Show references")

    map_local("n", "gk", vim.lsp.buf.signature_help, "Show signature help")
    map_local("n", "gK", function()
      vim.lsp.buf.signature_help({ close_events = { "BufHidden" } })
    end, "Show persist signature help (requires manual close)")

    map_local("n", "ga", vim.diagnostic.open_float, "Show diagnostics")
    map_local("n", "gA", function()
      vim.diagnostic.open_float({ close_events = { "BufHidden" } })
    end, "Show persist diagnostic (requires manual close)")
    map_local("i", "<C-s>", function()
      vim.lsp.buf.signature_help({ close_events = { "InsertLeave", "BufHidden" } })
    end, "Show persist signature help")

    -- LSP actions
    map_local("n", "<Leader>r", vim.lsp.buf.rename, "Rename symbol")

    map_local("n", "<Leader>a", vim.lsp.buf.code_action, "Code action")
  end,
})

-- Readonly files
au("BufRead", {
  group = native_group,
  pattern = { "*/.rustup/*", "*/.cargo/*", "*/.venv/*", "*/node_modules/*" },
  callback = function()
    vim.opt_local.readonly = true
    vim.opt_local.modifiable = false
  end,
})
