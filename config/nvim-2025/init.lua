--[[

nvim config dir ~/.config/nvim/
nvim data dir ~/.local/share/nvim/
nvim cache dir ~/.cache/nvim/

hence to start fresh
    rm -rf ~/.config/nvim  ~/.local/share/nvim ~/.cache/nvim

--]]

--[[

weekly maintenance
    :Lazy --> U
    :TSUpdateSync
-- :Mason -> U ??

--]]

--[[

NOTE:
  for better experience please install:
    fzf
    ripgrep
    bat
    git-delta

--]]

require("core/lesssgo") -- general vim options
                        -- before even setting up plugins
require("lazyyy")       -- lazy plugin manager
                        -- calling it lazyyy (3x y) - to avoid name clash
require("core/colors")  -- anything colour related, colorscheme and diff colours
require("core/keymaps") -- my custom keymaps, note a lot of keymaps are configured
                        -- next to the plugins
require("core/autocmd") -- my custom auto commands
