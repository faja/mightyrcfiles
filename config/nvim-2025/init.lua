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

-- :TSUpdateSync
-- :Mason -> U

--]]

require("core/lesssgo") -- general vim options
                        -- before even setting up plugins
require("core/lazy")    -- lazy plugin manager
require("core/colors")  -- anything colour related, colorscheme and diff colours
require("core/keymaps") -- my custom keymaps
