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
			{ "<leader>Ii", ":IBLToggle<cr>" },
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
		-- keys = {} - for some reason, I can not specify the mapping in keys
		--             property, hence using init function
		init = function()
			vim.keymap.set("n", "<leader>II", function()
				if vim.g.miniindentscope_disable then
					vim.g.miniindentscope_disable = false
				else
					vim.g.miniindentscope_disable = true
				end
			end, { noremap = true, silent = true })
		end,
	},
}
