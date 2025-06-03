return {
	{
		-- https://github.com/saghen/blink.cmp
		"saghen/blink.cmp",
		version = "1.*",

		-- dependencies = { 'rafamadriz/friendly-snippets' },

		opts = {
			fuzzy = { implementation = "prefer_rust_with_warning" },

			completion = {
				documentation = { auto_show = true },

				-- menu = { border = "rounded" },
				-- ghost_test = { enabled = true },
			},
			signature = { enabled = true },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				fallback = true, -- do not suppress buffer suggestions if there are onse from LSP
				providers = {
					buffer = { min_keyword_length = 3 }, -- start buffer completion after 3 chars
					lsp = { fallbacks = {} }, -- show buffer completions with LSP
				},
			},

			-- defaults:
			--   C-y                - to accept
			--   C-space            - open menu or open docs if already open
			--   C-n/C-p or Up/Down - next/previous item
			--   C-e                - hide menu
			--   C-k                - toggle signature help
			-- see :h blink-cmp-config-keymap for all defaults and defining your own keymap
			keymap = {
				preset = "default",
				["<CR>"] = { "select_and_accept", "fallback" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
