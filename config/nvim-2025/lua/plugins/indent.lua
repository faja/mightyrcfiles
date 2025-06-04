return {
	{
		-- https://github.com/lukas-reineke/indent-blankline.nvim
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- :help ibl.config (but once the plugin is loaded)
		opts = {
			enabled = false,
			indent = {
				char = { "|", "¦", "┆", "┊" },
			},
		},
		keys = {
			{ "<leader>I", ":IBLToggle<cr>" },
		},
	},
	{
		-- https://github.com/echasnovski/mini.indentscope
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
		},
	},
}
