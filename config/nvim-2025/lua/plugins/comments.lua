return {
	-- https://github.com/folke/todo-comments.nvim
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false, -- dont show icons
		highlight = {
			multiline = false, -- disable multines
		},
	},
}
