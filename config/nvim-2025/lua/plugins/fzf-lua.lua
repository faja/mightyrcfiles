return {
	-- https://github.com/ibhagwan/fzf-lua
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		grep = {
			hidden = true,
		},
	},
	keys = {
		-- find
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
		},
		{
			"<leader>fF",
			function()
				require("fzf-lua").git_files()
			end,
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = "~/.config/nvim" })
			end,
		},

		-- grep
		-- {"<leader>fw", function() require("fzf-lua").grep_cword() end },   -- search word under the cursor - disabled in favour of visual selection search
		-- {"<leader>fW", function() require("fzf-lua").grep_cword() end },   -- search WORD under the cursor - disabled in favour of visual selection search
		{
			"<leader>ff",
			function()
				require("fzf-lua").grep_visual()
			end,
			mode = "v",
		}, -- search visual selection -- this is amazing

		{
			"<leader>f/",
			function()
				require("fzf-lua").grep()
			end,
		}, -- search for whatever you type
		{
			"<leader>fj",
			function()
				require("fzf-lua").grep_project()
			end,
		}, -- search for whatever you type
		{
			"<leader>fl",
			function()
				require("fzf-lua").live_grep()
			end,
		}, -- live grep

		-- misc
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
		},

		-- git
		{
			"<leader>fi",
			function()
				require("fzf-lua").git_commits()
			end,
		}, -- just list commits
		{
			"<leader>fI",
			function()
				require("fzf-lua").git_bcommits()
			end,
		}, -- list commits for current buffer - nice1
	},
}
