return {
    -- https://github.com/ThePrimeagen/harpoon
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    -- menu = {
    --     -- width = vim.api.nvim_win_get_width(0) - 4,
    --     width = 120,
    -- }
    },
    init = function()
        require("harpoon"):setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })
    end,
    keys = {
        { "<leader>rr", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },

        { "<leader>ra", function() require("harpoon"):list():add() end },
        { "<leader>rm", function() require("harpoon"):list():next({ ui_nav_wrap = true }) end },
        { "<leader>rp", function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end },

        { "<leader>1", function() require("harpoon"):list():select(1) end },
        { "<leader>2", function() require("harpoon"):list():select(2) end },
        { "<leader>3", function() require("harpoon"):list():select(3) end },
        { "<leader>4", function() require("harpoon"):list():select(4) end },
    }
}
