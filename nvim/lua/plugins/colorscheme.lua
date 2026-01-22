return {
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'light'
            }
            require('onedark').load()
        end,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {},
        lazy = true,
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        lazy = true,
    },
}
