-- colorschemes ----------------------------------------------------------------
-- vim.cmd.colorscheme "kanagawa"
-- vim.cmd.colorscheme "gruvbox"
-- vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.colorscheme "onedarker"

-- other color related config --------------------------------------------------

-- transparency
vim.cmd("highlight Normal guibg=none") -- this makes "active" buffer transparent
                                       -- and the rest non transparent, exactly
                                       -- how I like it :chefkiss:

-- diff colors
vim.cmd [[
    highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=23 gui=bold guifg=LightGreen guibg=#01364F
    highlight DiffDelete cterm=bold ctermfg=1  ctermbg=23 gui=bold guifg=LightRed   guibg=#01364F
    highlight DiffChange cterm=bold ctermfg=10 ctermbg=23 gui=bold guifg=LightGreen guibg=#01364F
    highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=bold guifg=LightGreen guibg=DarkRed
]]

-- NonText is an end of line character
-- highlight NonText guifg=#30365F ctermfg=237 guibg=none ctermbg=233 gui=none cterm=none
-- highlight EndOfBuffer guibg=none
-- }}}
