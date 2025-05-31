return {
	"nvim-treesitter/nvim-treesitter", -- https://github.com/nvim-treesitter/nvim-treesitter
	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			sync_install = true,
			auto_install = false,
			ensure_installed = {
				-- :TSInstallInfo
				"bash", -- :TSInstall bash
				"comment", -- :TSInstall comment -- for TODO highlighting
				"dockerfile", -- :TSInstall dockerfile
				"go", -- :TSInstall go
				"hcl", -- :TSInstall hcl
				"json", -- :TSInstall json
				"markdown", -- :TSInstall markdown
				"terraform", -- :TSInstall terraform
				"toml", -- :TSInstall toml
				"yaml", -- :TSInstall yaml
			},
			highlight = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>",
					node_incremental = "<Enter>",
					scope_incremental = false, -- false means disabled
					node_decremental = "<Backspace>",
				},
			},
		})
	end,

	keys = {
		{ "<leader>ts", ":TSToggle highlight<cr>" },
	},
}
