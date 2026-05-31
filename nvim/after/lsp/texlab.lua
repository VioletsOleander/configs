---@type vim.lsp.Config
return {
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
          "--outdir",
          "build",
        },
        auxDirectory = "build",
        logDirectory = "build",
        pdfDirectory = "build",
      },
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
