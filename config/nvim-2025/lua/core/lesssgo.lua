--[[

generic config options lfg
loaded before lazy pugin system is initialised

for details/docs
    :help options

--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.fileencoding = "utf-8"  -- always utf-8 encoding

vim.opt.mouse = ""              -- disable mouse
vim.opt.errorbells = false      -- disable bell

vim.opt.number = true           -- numbers
vim.opt.relativenumber = true   -- relativenumber

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- colors and line
vim.opt.cursorline = true       -- highlight the line where the cursor is
vim.opt.colorcolumn = "80"      -- mark 80 char column
vim.opt.termguicolors = true
vim.opt.background = "dark"
-- vim.opt.signcolumn = "yes"   -- for now leaving the default

-- backup and swap
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.backupcopy = "yes"      -- just to make docker bind mount happy
-- vim.opt.undofile = true      -- save undo file, undodir is by default ~/.local/share/nvim/undo,
                                -- BUT, actually I don't like it

-- indentation && tabs
vim.opt.smartindent = true      -- smart indentation
vim.opt.tabstop = 4             -- how many spaces are shown per <TAB>
vim.opt.softtabstop = 4         -- how many spaces are inserted when <TAB> is hit
vim.opt.shiftwidth = 4          -- how many spaces to shift with << and >>
vim.opt.expandtab = true        -- when <TAB> is hit, replace it with <SPACE>*shiftwidth
                                -- NOTE, this is often overriden by .editorconfig, or filetype settings
                                -- NOTE, to actually insert a tab: CTRL+V <TAB>
-- big NOTE here, I'm using tpope/vim-sleuth plugin which automagically
-- adjusts shiftwidth and expandtab

-- misc
vim.opt.iskeyword:append("-")   -- do not separate words with `-`,
                                -- I found it useful especally using * to search
                                -- for words with a - in them
vim.opt.guicursor = ""          -- cursor as a block even in INSERT mode
vim.opt.hidden = true           -- no need to save before switching a buffer
vim.opt.updatetime = 50         -- quicker refresh
vim.opt.scrolloff = 12          -- scroll a bit earlier
vim.opt.wrap = false            -- don't wrap lines
vim.opt.foldmethod = "marker"   -- folding with {{{ }}}
-- vim.opt.showmode = false     -- disable showing which MODE we currently are

-- list aka show whitspace characters
vim.opt.list = true             -- show trailing spaces and tabs
vim.opt.listchars = { trail = '·', tab = '> ', nbsp = '+'}
                                -- yeah, I quite like it, but don't like the belows
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

-- TODO:
-- plugins related
-- cmp
-- vim.opt.completeopt = { "menuone", "noselect" }         -- for cmp, from lunar
-- vim.opt.completeopt = { "menu", "menuone", "noselect" } -- for cmp, my old
