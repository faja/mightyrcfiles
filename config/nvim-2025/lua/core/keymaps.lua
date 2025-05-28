--[[

just my custom generic keymaps,
plugin ones are configured next to plugins confuguration

--]]

local keymapopts = { noremap = true, silent = true }

-- some basic stuff
vim.keymap.set('n', 'Q', ':q<CR>', keymapopts) -- quit
vim.keymap.set('n', '*', '*zz', keymapopts) -- zz centers the screan, so it will center the screen after each serach, nojs!
vim.keymap.set('n', '<leader>v', ':e ~/.config/nvim/init.lua<CR>', keymapopts) -- edit init.lua main config file
vim.keymap.set('n', 'Y', 'yy', keymapopts) -- old good Y
vim.keymap.set('n', '<leader>/', ':noh<CR>', keymapopts) -- clear highliting

-- split
vim.keymap.set('n', '<leader>ss', '<c-w>v', keymapopts) -- split vertically   `|`
vim.keymap.set('n', '<leader>s-', '<c-w>s', keymapopts) -- split horizontally `-`
vim.keymap.set('n', '<leader>se', '<c-w>=', keymapopts) -- make splits equal

-- windows jumping and resizing
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', keymapopts) -- jump
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', keymapopts) -- jump
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', keymapopts) -- jump
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', keymapopts) -- jump

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

-- h4xoR
vim.keymap.set('v', 'p', '"_dP', keymapopts) -- in a visual mode, replace what we selected
                                             -- with what we have in registry
vim.keymap.set('n', '<s-x>', '"_x', keymapopts) -- when using SHIFT-x to remove a character, do not copy it to the register
                                                -- originaly I just had x here, but I really like the trick of "xp" to swap
                                                -- two characters in place, for all typos etc..
