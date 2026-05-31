---@type vim.lsp.Config
return {
  settings = {
    texlab = {
      forwardSearch = {
        executable = "SumatraPDF",
        args = {
          "-reuse-instance",
          "-forward-search",
          "%f",
          "%l",
          "%p",
        },
      },
    },
  },
}
