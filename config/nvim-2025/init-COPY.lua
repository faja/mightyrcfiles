require("packer").startup(function(use)

    -- telescope! ...note! useful functions require `rg` binary to be installed on the system
    use "nvim-telescope/telescope.nvim"                             -- telescope, https://github.com/nvim-telescope/telescope.nvim
    use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make'}  -- telescope fzf extension, https://github.com/nvim-telescope/telescope-fzf-native.nvim

    -- cmp plugins
    use "L3MON4D3/LuaSnip"          -- https://github.com/L3MON4D3/LuaSnip
    use "hrsh7th/nvim-cmp"     -- https://github.com/hrsh7th/nvim-cmp
    use "hrsh7th/cmp-path"     -- https://github.com/hrsh7th/cmp-path
    use "hrsh7th/cmp-buffer"   -- https://github.com/hrsh7th/cmp-buffer
    use "hrsh7th/cmp-cmdline"  -- https://github.com/hrsh7th/cmp-cmdline
    use "hrsh7th/cmp-nvim-lsp" -- https://github.com/hrsh7th/cmp-nvim-lsp
    use "saadparwaiz1/cmp_luasnip"  -- https://github.com/saadparwaiz1/cmp_luasnip

    -- lsp
    use "williamboman/mason.nvim"           -- https://github.com/williamboman/mason.nvim
    use "williamboman/mason-lspconfig.nvim" -- https://github.com/williamboman/mason-lspconfig.nvim
    use "jay-babu/mason-null-ls.nvim"       -- https://github.com/jay-babu/mason-null-ls.nvim
    use "neovim/nvim-lspconfig"             -- https://github.com/neovim/nvim-lspconfig
    -- use "jose-elias-alvarez/null-ls.nvim"   -- https://github.com/jose-elias-alvarez/null-ls.nvim
    use "nvimtools/none-ls.nvim"            -- https://github.com/nvimtools/none-ls.nvim
    use "onsails/lspkind-nvim"              -- https://github.com/onsails/lspkind-nvim
    use "ray-x/lsp_signature.nvim"          -- https://github.com/ray-x/lsp_signature.nvim

end)

-- plugin config {{{
-- cmp {{{
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup {
    mapping = {
        ["<c-q>"] = cmp.mapping.complete(), -- start completion manually
        ["<up>"] = cmp.mapping.select_prev_item(),
        ["<down>"] = cmp.mapping.select_next_item(),
        ["<c-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<enter>"] = cmp.mapping.confirm { select = true },
        ["<c-u>"] = cmp.mapping.scroll_docs(-1),
        ["<c-d>"] = cmp.mapping.scroll_docs(1),
    },

    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    formatting = {
        format = lspkind.cmp_format {
            mode = "symbol_text",
            menu = {
                snippet = "[snip]",
                buffer = "[buf]",
                nvim_lsp = "[lsp]",
                path = "[path]",
            },
        },
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'cmdline', keyword_length = 2 },
    { name = 'path' },
  }
})
-- }}}
-- telescope {{{
-- :help telescope
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<c-k>"] = require("telescope.actions").move_selection_previous,
                ["<c-j>"] = require("telescope.actions").move_selection_next,
            }
        },

        -- adding "--hiden --glob !.git/*" to default vimgrep_arguments, to search in hidden files
        vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--glob", "!.git/*" },
    },

    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "respect_case",      -- "smart_case" (default), "ignore_case", "respect_case"
        }
    }
}
require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
-- }}}
-- lsp {{{
-- TODO TODO TODO
--      check available lsp and null-ls servers
--          - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--          - https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
--          - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md


require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        -- available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        "gopls",
        "jsonnet_ls",
        "terraformls",
        "tflint",
        -- TODO bashls - npm
        -- TODO jsonls - npm
        -- docker? - npm
        -- docker-compose? - npm
        -- yamlls - yarn
        -- TODO ruby python rust
    },
}
require("mason-null-ls").setup {
    ensure_installed = {
        "goimports",
        "shellcheck",
        "shfmt", -- beautysh ?
        "yamllint",
    }
}

-- diagnostic config {{{
local diagnostic_signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = false, -- i don't want the annoying ghost message, just an icon on the left
    float = {
        border = "rounded",
        -- style = "minimal",
        -- source = "always",
        -- header = "",
        -- prefix = "",
    },
})
-- }}}
-- on_attach {{{
local on_attach = function(client, bufnr)
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- quite some keymaps are set up "globally" without "on_attach"
    keymap.set("n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    -- keymap.set("i", "<leader>L", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts) -- i'm not entirely sure what it does

    -- server specific on_attach functions
    if client.name == "gopls" then
        print('gopls server attached')
    end

    -- format on save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        })
    end
end
-- }}}
-- {{{ language server configs
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- go
lspconfig.gopls.setup { -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
    on_attach = on_attach,
    capabilities = capabilities,
    -- settings = {},-- if we want to put some settings, we do it this way
}

-- jsonnet
lspconfig.jsonnet_ls.setup{ -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonnet_ls
    on_attach = on_attach,
    capabilities = capabilities,
    -- autostart = false,
}

-- terraform
lspconfig.terraformls.setup{ -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#terraformls
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig.tflint.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
-- }}}
-- null-ls {{{
local null_ls = require("null-ls") -- replaced with
-- local null_ls = require("none-ls")

-- format on save
local null_ls_on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        })
    end
end

local null_ls_sources = {
    -- {{{ go
    null_ls.builtins.formatting.goimports,
    -- }}}
    -- {{{ sh
    null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci", "-bn", "-sr" }, -- for flags https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd#printer-flags
    }),
    null_ls.builtins.diagnostics.shellcheck,
    -- }}}
    -- {{{ yaml
    null_ls.builtins.diagnostics.yamllint,
    --[[ .config/yamllint/config
    rules:
      line-length:
        max: 160
    --]]
    -- }}}
}

null_ls.setup {
    sources = null_ls_sources,
    on_attach = null_ls_on_attach,
}

-- }}}

require("lsp_signature").setup {
    toggle_key = '<M-x>',
}
-- }}}
-- }}}

-- plugin remaps {{{
-- telescope {{{
vim.keymap.set('n', '<leader>O', ':Telescope find_files hidden=true<cr>')
vim.keymap.set('n', '<leader>o', ':Telescope git_files hidden=true<cr>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<cr>')
-- nnoremap <leader>FFn :Telescope find_files cwd=~/.config/nvim<cr>
-- nnoremap <leader>FF.. :Telescope find_files cwd=..<cr>

-- grep stuff
-- belows require ripgrep binary to be awailable
vim.keymap.set('n', '<leader>??', '<cmd>lua require("telescope.builtin").grep_string( { search = vim.fn.expand("<cword>") } )<cr>') -- search for word under the cursor
vim.keymap.set('n', '<leader>?/', '<cmd>lua require("telescope.builtin").grep_string( { search = vim.fn.input("Grep for > ") } )<cr>') -- search for ... whatever you type
vim.keymap.set('n', '<leader>?!', require('telescope.builtin').live_grep) -- lajw grep
-- }}}
-- git {{{
vim.keymap.set('n', ']C', '<cmd>Gitsigns next_hunk<cr>')
vim.keymap.set('n', '[C', '<cmd>Gitsigns prev_hunk<cr>')
vim.keymap.set('n', '<leader>Hp', '<cmd>Gitsigns preview_hunk<cr>')
vim.keymap.set('n', '<leader>Hs', '<cmd>Gitsigns stage_hunk<cr>')
vim.keymap.set('n', '<leader>HS', '<cmd>Gitsigns stage_buffer<cr>')
vim.keymap.set('n', '<leader>Hu', '<cmd>Gitsigns undo_stage_hunk<cr>')
vim.keymap.set('n', '<leader>Hu', '<cmd>Gitsigns reset_hunk<cr>')       -- undo single hunk
vim.keymap.set('n', '<leader>HU', '<cmd>Gitsigns reset_buffer<cr>')     -- undo whole file

-- lets give it a try
vim.keymap.set('n', '<leader>ig', '<cmd>LazyGit<cr>')
-- }}}
-- lsp {{{
-- all on_attach remaps ~> jumpstring:ree2ohh1Thohdael

vim.keymap.set("n", "gL", "<cmd>LspInfo<cr>", keymapopts)
vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", keymapopts)

-- :help vim.diagnostic.<TAB>
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", keymapopts)          -- show diagnostic floating window
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", keymapopts) -- jump to next diagnostic in buffer
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", keymapopts) -- jump to previous diagnostic in buffer
vim.keymap.set("n", "gq", "<cmd>lua vim.diagnostic.setqflist()<cr>", keymapopts)           -- quick fix list

-- }}}
-- }}}
