return {
    {
        -- https://github.com/nvim-tree/nvim-tree.lua
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },

        -- :help nvim-tree-setup
        opts = {
            git = { ignore = false },
            renderer = {
                add_trailing = true,
                symlink_destination = false,
                highlight_git = false,
                highlight_opened_files = "none",
                icons = {
                    show = {
                        git = true,
                        folder = false,
                        file = false,
                        folder_arrow = false,
                    },
                },
                indent_markers = {
                    enable = true,
                },
            },
            view = {
                adaptive_size = true,
            },
        },
        keys = {
            { "<leader><C-n>", "<cmd>NvimTreeToggle<cr>" },
            { "<leader><C-f>", "<cmd>NvimTreeFindFileToggle<cr>" },
        },
    },
    {
        -- https://github.com/echasnovski/mini.files
        "echasnovski/mini.files",
        version = false,
        opts = {
            mappings = {
                -- just the other way round as the defaults
                go_in_plus = "l",
                go_in = "L",
                go_out_plus = "h",
                go_out = "H",
            },
        },
        keys = {
            { "<C-n>", "<cmd>lua MiniFiles.open()<cr>" },
            {
                -- open minifiles and point to current buffer
                "<leader>F", function()
                    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                    MiniFiles.reveal_cwd()
                end
            },
        },
    },
}
