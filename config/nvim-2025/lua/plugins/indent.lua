return {
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- :help ibl.config (but once the plugin is loaded)
    opts = {
        enabled = false,
        indent = {
            char = {'|', '¦', '┆', '┊'},
        },
    },
    keys = {
        { "<leader>I", ":IBLToggle<cr>" },
    },
}
