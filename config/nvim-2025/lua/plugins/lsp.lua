return {
	{
		-- https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig", -- https://
		-- but actually all the work gonna be done by MASON, so:
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} }, -- https://github.com/mason-org/mason.nvim
			"mason-org/mason-lspconfig.nvim", -- https://github.com/mason-org/mason-lspconfig.nvim
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
			-- and just a small neat helper plugin to print LSP updates in the bottom right corner
			{ "j-hui/fidget.nvim", opts = {} }, -- https://github.com/j-hui/fidget.nvim

			-- autocompletion
			"saghen/blink.cmp",
		},

		config = function()
			-- here is the part where we define what binaries
			-- some LSPs I manage manually via OS package, so there are not
			-- listed here, but yet, I'm configuring them in the `servers` variable
			local binaries = {
				-- LSPs
				"gopls",
				"lua-language-server",
				-- lsp servers I might want:
				-- NON LSPs
				"stylua",

				-- TODO: just for future reference
				-- "bashls"
				-- "marksman"
				-- "gopls",
				-- "jsonnet_ls",
				-- "terraformls",
				-- "tflint",
				-- WHAT I USED TO HAVE FOR NULL LS
				-- "goimports",
				-- "shellcheck",
				-- "shfmt", -- beautysh ?
				-- "yamllint",
			}

			-- lets ask mason to install both LSP and NON LSP binaries
			require("mason-tool-installer").setup({ ensure_installed = binaries })

			-- here is the of LSPs I wanna use
			-- :help lspconfig-all - for a list of all the pre-configured LSPs
			local servers = {

				--  config table can contain
				--  - cmd (table): override the default command used to start the server
				--  - filetypes (table): override the default list of associated filetypes for the server
				--  - capabilities (table): override fields in capabilities
				--  - settings (table): override the default settings passed when initializing the server.

				gopls = {},
				lua_ls = {},
			}

			-- here is the part where we actually tells vim to attache/start an LSP
			local capabilities = require("blink.cmp").get_lsp_capabilities() -- extend capabilities from blink
			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table, managed via `binaries`
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			-- just a quick "Diagnostic Config" setup
			-- :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = false, -- i don't want the annoying ghost message, just an icon on the left
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("generic-lsp-attach", { clear = true }),
				callback = function(event)
					local keymapopts = { buffer = event.buf, noremap = true, silent = true }

					-- diagnostics keymaps
					-- :help vim.diagnostic.<TAB>
					vim.keymap.set("n", "gq", vim.diagnostic.setqflist, keymapopts) -- show float
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, keymapopts) -- quick fix list
					vim.keymap.set("n", "gz", function() -- toggle diagnostics
						if vim.diagnostic.is_enabled() then
							vim.diagnostic.enable(false)
						else
							vim.diagnostic.enable()
						end
					end, keymapopts)
					-- these two seems to be already set
					-- vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", keymapopts) -- jump to next diagnostic in buffer
					-- vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", keymapopts) -- jump to previous diagnostic in buffer
				end,
			})
		end,

		----#--   TODO: review this
		----#--   vim.api.nvim_create_autocmd('LspAttach', {
		----#--     group = vim.api.nvim_create_augroup('generic-lsp-attach', { clear = true }),
		----#--     callback = function(event)
		----#--       local map = function(keys, func, desc, mode)
		----#--         mode = mode or 'n'
		----#--         vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
		----#--       end

		----#--       -- Rename the variable under your cursor.
		----#--       --  Most Language Servers support renaming across files, etc.
		----#--       map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

		----#--       -- Execute a code action, usually your cursor needs to be on top of an error
		----#--       -- or a suggestion from your LSP for this to activate.
		----#--       map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

		----#--       -- Find references for the word under your cursor.
		----#--       map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

		----#--       -- Jump to the implementation of the word under your cursor.
		----#--       --  Useful when your language has ways of declaring types without an actual implementation.
		----#--       map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

		----#--       -- Jump to the definition of the word under your cursor.
		----#--       --  This is where a variable was first declared, or where a function is defined, etc.
		----#--       --  To jump back, press <C-t>.
		----#--       map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

		----#--       -- WARN: This is not Goto Definition, this is Goto Declaration.
		----#--       --  For example, in C this would take you to the header.
		----#--       map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

		----#--       -- Fuzzy find all the symbols in your current document.
		----#--       --  Symbols are things like variables, functions, types, etc.
		----#--       map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

		----#--       -- Fuzzy find all the symbols in your current workspace.
		----#--       --  Similar to document symbols, except searches over your entire project.
		----#--       map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

		----#--       -- Jump to the type of the word under your cursor.
		----#--       --  Useful when you're not sure what type a variable is and you want to see
		----#--       --  the definition of its *type*, not where it was *defined*.
		----#--       map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

		----#--       -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
		----#--       ---@param client vim.lsp.Client
		----#--       ---@param method vim.lsp.protocol.Method
		----#--       ---@param bufnr? integer some lsp support methods only in specific files
		----#--       ---@return boolean
		----#--       local function client_supports_method(client, method, bufnr)
		----#--         if vim.fn.has 'nvim-0.11' == 1 then
		----#--           return client:supports_method(method, bufnr)
		----#--         else
		----#--           return client.supports_method(method, { bufnr = bufnr })
		----#--         end
		----#--       end

		----#--       -- The following two autocommands are used to highlight references of the
		----#--       -- word under your cursor when your cursor rests there for a little while.
		----#--       --    See `:help CursorHold` for information about when this is executed
		----#--       --
		----#--       -- When you move your cursor, the highlights will be cleared (the second autocommand).
		----#--       local client = vim.lsp.get_client_by_id(event.data.client_id)
		----#--       if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
		----#--         local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
		----#--         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		----#--           buffer = event.buf,
		----#--           group = highlight_augroup,
		----#--           callback = vim.lsp.buf.document_highlight,
		----#--         })

		----#--         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
		----#--           buffer = event.buf,
		----#--           group = highlight_augroup,
		----#--           callback = vim.lsp.buf.clear_references,
		----#--         })

		----#--         vim.api.nvim_create_autocmd('LspDetach', {
		----#--           group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
		----#--           callback = function(event2)
		----#--             vim.lsp.buf.clear_references()
		----#--             vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
		----#--           end,
		----#--         })
		----#--       end

		----#--       -- The following code creates a keymap to toggle inlay hints in your
		----#--       -- code, if the language server you are using supports them
		----#--       --
		----#--       -- This may be unwanted, since they displace some of your code
		----#--       if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
		----#--         map('<leader>th', function()
		----#--           vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
		----#--         end, '[T]oggle Inlay [H]ints')
		----#--       end
		----#--     end,
		----#--   })
	},
}
