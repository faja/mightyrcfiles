return {
	-- --
	--[[
        helpers first
    --]]
	{
		-- bunch of lua functions that other plugins are using, eg telescope
		"nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
	},
	-- {
	--     WARN: I wonder if I really need this
	--     WARN: testing with disabled
	--     -- language pack for syntax and filetypes
	--     "sheerun/vim-polyglot" -- https://github.com/sheerun/vim-polyglot
	-- },
	{
		-- icons
		-- please install nerdfonts first: https://www.nerdfonts.com/
		"nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
		opts = {},
	},

	--[[
        real plugins
    --]]
	{ "tpope/vim-surround" }, -- https://github.com/tpope/vim-surround
	{ "tpope/vim-sleuth" }, -- https://github.com/tpope/vim-sleuth, bundled in vim-polyglot, hence disabled
	{
		-- split window maximizer
		"szw/vim-maximizer", -- https://github.com/szw/vim-maximizer
		lazy = true,
		keys = {
			{ "<leader>sm", ":MaximizerToggle<cr>" },
		},
	},
	{},
}
