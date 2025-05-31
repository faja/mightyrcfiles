return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		opts = {
			formatters_by_ft = {
				-- NOTE:
				--     run :checkhealth conform
				-- to check if we have installed all we need

				-- examples
				-- lua = { "stylua" },
				-- -- Conform will run multiple formatters sequentially
				-- python = { "isort", "black" },
				-- -- You can customize some of the format options for the filetype (:help conform.format)
				-- rust = { "rustfmt", lsp_format = "fallback" },
				-- -- Conform will run the first available formatter
				-- javascript = { "prettierd", "prettier", stop_after_first = true },

				go = { "gofmt" },
				terraform = { "terraform_fmt" }, -- this internally runs `terraform fmt`
				lua = { "stylua" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 800,
				lsp_format = "fallback",
			},
		},
		-- keys disabled bc I'm using autoformat on save
		-- keys = {
		--     -- cf = code format
		--     { "<leader>cf", function() require("conform").format({ lsp_format = "fallback", timeout_ms = 800 }) end },
		-- },
	},
}
