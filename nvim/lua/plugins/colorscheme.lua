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
        -- the light theme is too grayish for my taste
        -- so prefer the light variant of onedarkpro
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        lazy = true,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {},
        lazy = true,
    },
}
