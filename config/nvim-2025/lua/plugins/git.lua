return {
    {
        -- https://github.com/tpope/vim-fugitive
        "tpope/vim-fugitive",
        init = function()
            vim.opt.diffopt:append('vertical') -- use vertical split by default when u dd
        end
    },

    {
        -- https://github.com/sindrets/diffview.nvim
        "sindrets/diffview.nvim",
    },

    {
        -- https://github.com/lewis6991/gitsigns.nvim
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {},
        keys = {
            { "]C",         "<cmd>Gitsigns next_hunk<cr>" },
            { "[C",         "<cmd>Gitsigns prev_hunk<cr>" },
            { "<leader>Hp", "<cmd>Gitsigns preview_hunk<cr>" },
            { "<leader>Hs", "<cmd>Gitsigns stage_hunk<cr>" },
            { "<leader>HS", "<cmd>Gitsigns stage_buffer<cr>" },
            { "<leader>Hu", "<cmd>Gitsigns reset_hunk<cr>" },   -- undo single hunk
            { "<leader>HU", "<cmd>Gitsigns reset_buffer<cr>" }, -- undo whole file
        },
    },
}
