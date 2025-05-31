--[[

just my custom generic keymaps,
plugin ones are configured next to plugins confuguration, but here is the list:

-- FILE EXPLORERS
leader><C-n>  --  nvim tree toggle
leader><C-f>  --  nvim tree find file toggle

            { "<C-n>", "<cmd>lua MiniFiles.open()<cr>" },
            {
                -- open minifiles and point to current buffer
                "<leader>F", function()
                    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                    MiniFiles.reveal_cwd()
                end

        { "<leader>I", ":IBLToggle<cr>" },

-- DIAGNOSTICS
                    vim.keymap.set("n", "gq", vim.diagnostic.setqflist, keymapopts)    -- show float
                    vim.keymap.set("n", "gl", vim.diagnostic.open_float, keymapopts)   -- quick fix list
                    vim.keymap.set("n", "gz", function() -- toggle diagnostics
--
-- FZF LUA
--
        {"<leader>ff", function() require("fzf-lua").files() end },
        {"<leader>fF", function() require("fzf-lua").git_files() end },
        {"<leader>fo", function() require("fzf-lua").oldfiles() end },
        {"<leader>fc", function() require("fzf-lua").files({ cwd = "~/.config/nvim" }) end },
        {"<leader><leader>", function() require("fzf-lua").buffers() end },

        -- grep
        {"<leader>fw", function() require("fzf-lua").grep_cword() end },   -- search word under the cursor
        {"<leader>fW", function() require("fzf-lua").grep_cword() end },   -- search WORD under the cursor
        {"<leader>ff", function() require("fzf-lua").grep_visual() end, mode="v" },  -- search visual selection -- this is amazing

        {"<leader>f/", function() require("fzf-lua").grep() end },         -- search for whatever you type
        {"<leader>fj", function() require("fzf-lua").grep_project() end }, -- search for whatever you type
        {"<leader>fl", function() require("fzf-lua").live_grep() end },    -- live grep

        -- misc
        {"<leader>fh", function() require("fzf-lua").helptags() end },
        {"<leader>fb", function() require("fzf-lua").builtin() end },

        -- git
        {"<leader>fi", function() require("fzf-lua").git_commits() end },  -- just list commits
        {"<leader>fI", function() require("fzf-lua").git_bcommits() end }, -- list commits for current buffer - nice1

-- GIT
            { "]C",         "<cmd>Gitsigns next_hunk<cr>" },
            { "[C",         "<cmd>Gitsigns prev_hunk<cr>" },
            { "<leader>Hp", "<cmd>Gitsigns preview_hunk<cr>" },
            { "<leader>Hs", "<cmd>Gitsigns stage_hunk<cr>" },
            { "<leader>HS", "<cmd>Gitsigns stage_buffer<cr>" },
            { "<leader>Hu", "<cmd>Gitsigns reset_hunk<cr>" },   -- undo single hunk
            { "<leader>HU", "<cmd>Gitsigns reset_buffer<cr>" }, -- undo whole file

-- HARPOON
    keys = {
        { "<leader>rr", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },

        { "<leader>ra", function() require("harpoon"):list():add() end },
        { "<leader>rm", function() require("harpoon"):list():next({ ui_nav_wrap = true }) end },
        { "<leader>rp", function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end },

        { "<leader>1", function() require("harpoon"):list():select(1) end },
        { "<leader>2", function() require("harpoon"):list():select(2) end },
        { "<leader>3", function() require("harpoon"):list():select(3) end },
        { "<leader>4", function() require("harpoon"):list():select(4) end },

-- MISC
<leader>sm   -- window maximizer
    keys = {
        { "<leader>ts", ":TSToggle highlight<cr>" },
    },
--]]

local keymapopts = { noremap = true, silent = true }

-- some basic stuff
vim.keymap.set('n', 'Q', ':q<CR>', keymapopts)                                 -- quit
vim.keymap.set('n', '*', '*zz', keymapopts)                                    -- zz centers the screan, so it will center the screen after each serach, nojs!
vim.keymap.set('n', '<leader>v', ':e ~/.config/nvim/init.lua<CR>', keymapopts) -- edit init.lua main config file
vim.keymap.set('n', 'Y', 'yy', keymapopts)                                     -- old good Y
vim.keymap.set('n', '<leader>/', ':noh<CR>', keymapopts)                       -- clear highliting

-- split
vim.keymap.set('n', '<leader>ss', '<c-w>v', keymapopts) -- split vertically   `|`
vim.keymap.set('n', '<leader>s-', '<c-w>s', keymapopts) -- split horizontally `-`
vim.keymap.set('n', '<leader>se', '<c-w>=', keymapopts) -- make splits equal

-- windows jumping and resizing
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', keymapopts)           -- jump
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', keymapopts)           -- jump
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', keymapopts)           -- jump
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', keymapopts)           -- jump

vim.keymap.set('n', '<s-up>', ':resize +2<cr>', keymapopts)             -- resize
vim.keymap.set('n', '<s-down>', ':resize -2<cr>', keymapopts)           -- resize
vim.keymap.set('n', '<s-left>', ':vertical resize +2<cr>', keymapopts)  -- resize
vim.keymap.set('n', '<s-right>', ':vertical resize -2<cr>', keymapopts) -- resize

-- CTRL+hjkl = ESCAPE
-- vim.keymap.set('i', '<c-h>', '<ESC>l', keymapopts) -- <c-h> == <backspace> in linux, disabling
vim.keymap.set('i', '<c-j>', '<ESC>l', keymapopts)
vim.keymap.set('i', '<c-k>', '<ESC>l', keymapopts)
vim.keymap.set('i', '<c-l>', '<ESC>l', keymapopts)

-- scroll
vim.keymap.set('n', '<c-k>', '<c-y>k', keymapopts)
vim.keymap.set('n', '<c-j>', '<c-e>j', keymapopts)

-- tabs -- but I don't use tabs that often anymore
vim.keymap.set('n', '<c-t>', ':tabnew<CR>', keymapopts)
vim.keymap.set('n', '(', ':tabprev<CR>', keymapopts)
vim.keymap.set('n', ')', ':tabnext<CR>', keymapopts)
vim.keymap.set('n', '<leader>(', ':tabmove -1<CR>', keymapopts)
vim.keymap.set('n', '<leader>)', ':tabmove +1<CR>', keymapopts)

-- quick fix list
vim.keymap.set('n', '<leader>n', ':cnext<CR>', keymapopts)
vim.keymap.set('n', '<leader>p', ':cprevious<CR>', keymapopts)

-- pwd and cd
vim.keymap.set('n', '<leader>%%', ':pwd<CR>', { noremap = true })      -- print working directory
vim.keymap.set('n', '<leader>%!', ':cd %:p:h<CR>', { noremap = true }) -- cd to the location of the current opened buffer
-- vim.keymap.set('n', '<leader>%!', ':echo expand('%:p')<cr>')        -- print full path to the current file, disabling, as it's the same as: `CTRL+g` (or `1` then `CTRL+g`)

-- misc
vim.keymap.set('n', "<leader>sl", ":set list!<cr>", keymapopts) -- toggle show list (characters)
vim.keymap.set('n', "<leader>sw", ":set wrap!<cr>", keymapopts) -- toggle wrapping lines

-- h4xxxoR ---------------------------------------------------------------------
vim.keymap.set('v', 'p', '"_dP', keymapopts)    -- in a visual mode, replace what we selected
-- with what we have in registry
vim.keymap.set('n', '<S-x>', '"_x', keymapopts) -- when using SHIFT-x to remove a character, do not copy it to the register
-- originaly I just had x here, but I really like the trick of "xp" to swap

-- replace word under the cursor
vim.keymap.set("n", '<leader><S-s>', ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true })

-- copy filepath
vim.keymap.set("n", "<leader><S-c>", function()
    local filePath = vim.fn.expand("%:p") -- get file path
    vim.fn.setreg("*", filePath)          -- copy to the clipboard register "*
    print(filePath)
end)                                      -- copy file path to the clipboard register -> hence system clipboard
