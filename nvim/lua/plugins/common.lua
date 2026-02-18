return {
	{
		-- https://github.com/nvim-lua/plenary.nvim
		-- bunch of lua functions that other plugins are using, eg telescope
		"nvim-lua/plenary.nvim",
	},
	{
		-- https://github.com/sheerun/vim-polyglot
		-- language pack for syntax and filetypes
		"sheerun/vim-polyglot",
	},
	{
		-- https://github.com/nvim-tree/nvim-web-devicons
		-- icons
		-- please install nerdfonts first: https://www.nerdfonts.com/
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		-- https://github.com/tpope/vim-surround
		"tpope/vim-surround",
	},
	-- { sleuth optimized version is bundled in vim-polyglot, hence disabled
	-- 	-- https://github.com/tpope/vim-sleuth,
	-- 	"tpope/vim-sleuth",
	-- },
	{
		-- https://github.com/szw/vim-maximizer
		-- split window maximizer
		"szw/vim-maximizer",
		lazy = true,
		keys = {
			{ "<leader>sm", ":MaximizerToggle<cr>" },
		},
	},
}
