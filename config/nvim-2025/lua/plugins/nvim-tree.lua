return {
    "nvim-tree/nvim-tree.lua", -- https://github.com/nvim-tree/nvim-tree.lua
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
        { "<C-n>", "<cmd>NvimTreeToggle<cr>" },
        { "<leader>f", "<cmd>NvimTreeFindFileToggle<cr>" },
    },
}
