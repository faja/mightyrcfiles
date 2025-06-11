--[[

just my custom generic keymaps,
plugin ones are configured next to plugins confuguration, but here is the list:

-- FILE EXPLORER {{{
leader><C-n>  -- nvim tree toggle
leader>F      -- nvim tree find file toggle
}}}
-- DIAGNOSTICS {{{
]d  -- jump to next diagnostic in buffer
[d  -- jump to previous diagnostic in buffer
gl  -- diagnostics floating window
gq  -- diagnostics to quick fix list
gz  -- toggle diagnostics
}}}
-- FZF LUA {{{
-- find
<leader>ff    -- files
<leader>fF    -- git files
<leader>fo    -- recently opened files
<leader>fc    -- nvim config dir
-- grep
<leader>ff    -- V MODE -- search visual selection -- this is amazing
<leader>f/    -- search for whatever you type
<leader>fj    -- project lines grep
<leader>fl    -- live grep
-- misc
<leader>fh    -- help tags
<leader>fb    -- fzf-lua builtins
-- git
<leader>fi    -- git commits
<leader>fI    -- git commits but for current buffer only - nice1
}}}
-- GIT {{{
]C           -- next hunk
[C           -- previous hunk
<leader>Hp   -- preview/diff single hunk
<leader>Hs   -- stage single hunk
<leader>HS   -- stage all hunks
<leader>Hu   -- undo single hunk
<leader>HU   -- undo all hunks
}}}
-- HARPOON {{{
<leader>rr  -- open harpoon menu
<leader>ra  -- add
<leader>rm  -- next
<leader>rp  -- preview
<leader>1   -- jump to 1
<leader>2   -- jump to 2
<leader>3   -- jump to 3
<leader>4   -- jump to 4
}}}
-- MISC {{{
<leader>I    -- toggle indentation guides
<leader>sm   -- window maximizer
<leader>ts   -- toggle treesitter highlighting
}}}
--]]

local keymapopts = { noremap = true, silent = true }

-- some basic stuff
vim.keymap.set("n", "Q", ":q<CR>", keymapopts) -- quit
vim.keymap.set("n", "*", "*zz", keymapopts) -- zz centers the screan, so it will center the screen after each serach, nojs!
-- vim.keymap.set("n", "<leader>v", ":e ~/.config/nvim/init.lua<CR>", keymapopts) -- edit init.lua main config file
-- :pointup: disabled in favour of <leader>fc
vim.keymap.set("n", "Y", "yy", keymapopts) -- old good Y
vim.keymap.set("n", "<leader>/", ":noh<CR>", keymapopts) -- clear highliting

-- split
vim.keymap.set("n", "<leader>ss", "<c-w>v", keymapopts) -- split vertically   `|`
vim.keymap.set("n", "<leader>s-", "<c-w>s", keymapopts) -- split horizontally `-`
vim.keymap.set("n", "<leader>se", "<c-w>=", keymapopts) -- make splits equal

-- windows jumping and resizing
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", keymapopts) -- jump
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", keymapopts) -- jump
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", keymapopts) -- jump
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", keymapopts) -- jump

vim.keymap.set("n", "<s-up>", ":resize +2<cr>", keymapopts) -- resize
vim.keymap.set("n", "<s-down>", ":resize -2<cr>", keymapopts) -- resize
vim.keymap.set("n", "<s-left>", ":vertical resize +2<cr>", keymapopts) -- resize
vim.keymap.set("n", "<s-right>", ":vertical resize -2<cr>", keymapopts) -- resize

-- CTRL+hjkl = ESCAPE
-- vim.keymap.set('i', '<c-h>', '<ESC>l', keymapopts) -- <c-h> == <backspace> in linux, disabling
vim.keymap.set("i", "<c-j>", "<ESC>l", keymapopts)
vim.keymap.set("i", "<c-k>", "<ESC>l", keymapopts)
vim.keymap.set("i", "<c-l>", "<ESC>l", keymapopts)

-- scroll
vim.keymap.set("n", "<c-k>", "<c-y>k", keymapopts)
vim.keymap.set("n", "<c-j>", "<c-e>j", keymapopts)

-- tabs -- but I don't use tabs that often anymore
vim.keymap.set("n", "<c-t>", ":tabnew<CR>", keymapopts)
vim.keymap.set("n", "(", ":tabprev<CR>", keymapopts)
vim.keymap.set("n", ")", ":tabnext<CR>", keymapopts)
vim.keymap.set("n", "<leader>(", ":tabmove -1<CR>", keymapopts)
vim.keymap.set("n", "<leader>)", ":tabmove +1<CR>", keymapopts)

-- quick fix list
vim.keymap.set("n", "<leader>n", ":cnext<CR>", keymapopts)
vim.keymap.set("n", "<leader>p", ":cprevious<CR>", keymapopts)

-- pwd and cd
vim.keymap.set("n", "<leader>%%", ":pwd<CR>", { noremap = true }) -- print working directory
vim.keymap.set("n", "<leader>%!", ":cd %:p:h<CR>", { noremap = true }) -- cd to the location of the current opened buffer
-- vim.keymap.set('n', '<leader>%!', ':echo expand('%:p')<cr>')        -- print full path to the current file, disabling, as it's the same as: `CTRL+g` (or `1` then `CTRL+g`)

-- misc
vim.keymap.set("n", "<leader>sl", ":set list!<cr>", keymapopts) -- toggle show list (characters)
vim.keymap.set("n", "<leader>sw", ":set wrap!<cr>", keymapopts) -- toggle wrapping lines

-- h4xxxoR ---------------------------------------------------------------------
vim.keymap.set("v", "p", '"_dP', keymapopts) -- in a visual mode, replace what we selected
-- with what we have in registry
vim.keymap.set("n", "<S-x>", '"_x', keymapopts) -- when using SHIFT-x to remove a character, do not copy it to the register
-- originaly I just had x here, but I really like the trick of "xp" to swap

-- replace word under the cursor
vim.keymap.set("n", "<leader><S-s>", ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true })

-- copy filepath
vim.keymap.set("n", "<leader><S-c>", function()
	local filePath = vim.fn.expand("%:p") -- get file path
	vim.fn.setreg("*", filePath) -- copy to the clipboard register "*
	print(filePath)
end) -- copy file path to the clipboard register -> hence system clipboard
