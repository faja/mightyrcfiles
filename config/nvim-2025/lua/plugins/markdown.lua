return {
	{
		-- https://github.com/OXY2DEV/markview.nvim
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			preview = {
				enable = false,
				icon_provider = "devicons", -- "internal" | "mini" | "devicons"
			},
		},
	},
	{
		-- https://github.com/brianhuster/live-preview.nvim
		"brianhuster/live-preview.nvim",
		-- :h livepreview
	},
}
