return {
	--   I kinda don't use it, and there was this annoying warning
	--   about treesitter plugin being loaded before markview
	--	{
	--		-- https://github.com/OXY2DEV/markview.nvim
	--		"OXY2DEV/markview.nvim",
	--		lazy = false,
	--		dependencies = { "nvim-tree/nvim-web-devicons" },
	--		opts = {
	--			preview = {
	--				enable = false,
	--				icon_provider = "devicons", -- "internal" | "mini" | "devicons"
	--			},
	--		},
	--		keys = {
	--			{ "<leader>mv", ":Markview<cr>" },
	--		},
	--	},
	{
		-- https://github.com/brianhuster/live-preview.nvim
		"brianhuster/live-preview.nvim",
		-- :h livepreview
		keys = {
			{ "<leader>mp", ":LivePreview start<cr>" },
		},
	},
}
