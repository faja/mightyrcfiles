-- plugin install {{{
            --
require("packer").startup(function(use)

    -- bunch of lua functions that other plugins are using, eg telescope
    use "nvim-lua/plenary.nvim" -- https://github.com/nvim-lua/plenary.nvim

    -- language pack for syntax and filetypes
    use "sheerun/vim-polyglot" -- https://github.com/sheerun/vim-polyglot

    -- random stuff
    use "aymericbeaumet/vim-symlink"   -- deals with symlinks correctly
    use "moll/vim-bbye"                -- symlink dependency, required in order to symlink work properly in diff mode, https://github.com/moll/vim-bbye
    use "tpope/vim-surround"           -- surround plugin
    use "szw/vim-maximizer"            -- split window maximizer, https://github.com/szw/vim-maximizer
    use "kyazdani42/nvim-web-devicons" -- icons, you must install nerdfonts first: https://www.nerdfonts.com/
    use "ThePrimeagen/harpoon"         -- https://github.com/ThePrimeagen/harpoon

    -- git
    use "tpope/vim-fugitive"      -- https://github.com/tpope/vim-fugitive
    use "lewis6991/gitsigns.nvim" -- https://github.com/lewis6991/gitsigns.nvim
    use "sindrets/diffview.nvim"  -- https://github.com/sindrets/diffview.nvim

    -- nerd tree
    use "kyazdani42/nvim-tree.lua" -- https://github.com/kyazdani42/nvim-tree.lua

    -- lualine, quick and light vim status line
    use "nvim-lualine/lualine.nvim" -- https://github.com/nvim-lualine/lualine.nvim

    -- indent
    use "lukas-reineke/indent-blankline.nvim" -- https://github.com/lukas-reineke/indent-blankline.nvim

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

    -- treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ':TSUpdate'} -- https://github.com/nvim-treesitter/nvim-treesitter

    -- lsp
    use "williamboman/mason.nvim"           -- https://github.com/williamboman/mason.nvim
    use "williamboman/mason-lspconfig.nvim" -- https://github.com/williamboman/mason-lspconfig.nvim
    use "jay-babu/mason-null-ls.nvim"       -- https://github.com/jay-babu/mason-null-ls.nvim
    use "neovim/nvim-lspconfig"             -- https://github.com/neovim/nvim-lspconfig
    -- use "jose-elias-alvarez/null-ls.nvim"   -- https://github.com/jose-elias-alvarez/null-ls.nvim
    use "nvimtools/none-ls.nvim"            -- https://github.com/nvimtools/none-ls.nvim
    use "onsails/lspkind-nvim"              -- https://github.com/onsails/lspkind-nvim
    use "ray-x/lsp_signature.nvim"          -- https://github.com/ray-x/lsp_signature.nvim

    -- markdown
    use "OXY2DEV/markview.nvim"             -- https://github.com/OXY2DEV/markview.nvim
    use "brianhuster/live-preview.nvim"     -- https://github.com/brianhuster/live-preview.nvim
      -- :h livepreview
end)
-- }}}

-- plugin config {{{
-- git {{{
require("gitsigns").setup()
-- }}}
-- lualine {{{
require('lualine').setup()
-- }}}
-- devicons {{{
require('nvim-web-devicons').setup()
-- }}}
-- indent {{{
require("ibl").setup {
    -- help :ibl.config
    enabled = false,
    indent = {
      char = {'|', '¦', '┆', '┊'},
    },
}
-- }}}
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
-- treesitter {{{
require("nvim-treesitter.configs").setup {
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    ensure_installed = {
        "bash",
        "c", -- this is part of the nvim installation anyway, lib/nvim/parser/c.so, but I'm adding it here explicitly
        "comment", -- for TODO highlighting
        "dockerfile",
        "go",
        "hcl",
        "json",
        "jsonnet",
        "lua", -- part of the nvim installation, lib/nvim/parser/lua.so
        "markdown",
        "query", -- part of the nvim installation, lib/nvim/parser/query.so
        "terraform",
        "vim", -- part of the nvim installation, lib/nvim/parser/vim.so
        "vimdoc", -- part of the nvim installation, lib/nvim/parser/vimdoc.so
        "yaml",
    },
    -- ensure_installed = "all",
    -- ignore_install = { "..." },
    sync_install = true, -- install parsers synchronously
    auto_install = true,  -- automatically install missing parsers when entering buffer
                          -- once I figure out all parsers I need please consider disabling

    highlight = {
        enable = true,
        -- disable = { "..." },
    },

    autopairs = {
        enable = false,
    },

    indent = {
        enable = false,
        -- disable = { "...", "..." },
    }
}
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
require("harpoon").setup({
    menu = {
        -- width = vim.api.nvim_win_get_width(0) - 4,
        width = 120,
    }
})

require('livepreview.config').set()
require('markview').setup({
    preview = {
        enable = false,
    }
})
-- }}}

-- plugin remaps {{{

-- nvim-tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle<cr>')

-- indent
vim.keymap.set('n', '<leader>I', ':IBLToggle<cr>')

-- maximizer
vim.keymap.set('n', '<leader>sm', ':MaximizerToggle<cr>')

-- treesitter
vim.keymap.set('n', '<leader>tt', ':TSToggle highlight<cr>')

-- harpoon
vim.keymap.set('n', '<leader>rr', ':lua require("harpoon.ui").toggle_quick_menu()<cr>')
vim.keymap.set('n', '<leader>rR', ':Telescope harpoon marks<cr>')
vim.keymap.set('n', '<leader>ra', ':lua require("harpoon.mark").add_file()<cr>')
vim.keymap.set('n', '<leader>rm', ':lua require("harpoon.ui").nav_next()<cr>')
vim.keymap.set('n', '<leader>rp', ':lua require("harpoon.ui").nav_prev()<cr>')
vim.keymap.set('n', '<leader>r1', ':lua require("harpoon.ui").nav_file(1)<cr>')
vim.keymap.set('n', '<leader>r2', ':lua require("harpoon.ui").nav_file(2)<cr>')
vim.keymap.set('n', '<leader>r3', ':lua require("harpoon.ui").nav_file(3)<cr>')
vim.keymap.set('n', '<leader>r4', ':lua require("harpoon.ui").nav_file(4)<cr>')

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

-- autocmd {{{
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {pattern='*.nomadtpl', command='set filetype=hcl'})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {pattern='*.nomad.j2', command='set filetype=hcl'})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {pattern='docker-compose.y*ml.*', command='set filetype=docker-compose'})
vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern='*', command=[[%s/\s\+$//e]]}) -- remove trailing white spaces
-- }}}

-- LUA HOWTOs {{{
-- simgle line comment
--[[
  multi line comment
--]]

--[[

-- requiring
require("my_custom_stuff") -- that would call ~/.config/nvim/lua/my_custom_stuff.lua


-- create local variable and reuse it for conciseness
local opt = vim.opt
opt.number = true -- instead of vim.opt.number = true


-- call some function and check the status
local colorscheme = "xxx"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    print("Colorscheme " .. colorscheme .. " not found")
    return
end

--]]
-- }}}

-- VIM TIPS AND TRIX USAGE HOWTO: TODO MOVE THIS TO MANUALS {{{
--[[

<c-w>T - move current window to new tab

:set            - shows vars different from defaults
:set all        - shows all values
:set foo?       - shows the value of foo
:set foo+=opt   - add opt to the value w/o changing others
:set foo-=opt   - remove opt from value
:set foo&       - reset foo to default value
:setlocal foo   - only the current buffers

:set textwidth=0
:set wrapmargin=0

{{{ surround
ds"  -- remove surrounded " ... "example"
cs"' -- replace " with '    ... "example"
}}}

{{{ fugitive
# add patch
- go to status `:G`
- put cursor on a file, and hit `i`
- visual block/line you want to add, and use `-` to stage/unstage

# :Git blame
- `g?` - for help
- `-`  - reblame at the commit          - this basically means - rerender the file at this particular commit
- `P`  - reblame at the previous commit - this measn - show me how the file looked like before this one was added

# navigate through the Gclog
- open a file
- :Gclog -- %    - this is pretty cool, it will show you all the commits related to this file
- select a commit you want to interact with
- navigate to the changed file with `]m`
- then you can press `o`(- split), `gO` (| split), or `O` (new tab) to open
    - a diff
    - how the file looked liek BEFORE the change
    - how the file looks liek AFTER the change

# :Gedit
- `:Gedit HASH:file` - opens a file at a specifc commit
- `:Gedit HASH:%` - opens current file ata specific commit
}}}

{{{ vim diff (normal diff)
            ]c - jump to next change
            [c - jump to prev change
}}}

{{{ diffview
# see changes for a single path or file
  :DiffviewOpen 5618c3e5bf62847c1b9f7420783ec27dd438244e..b386ffca433ed6a49b76147758857d1a4f84caba -- vpc/outputs.tf
this is equivalent of
  git diff 5618c3e5bf62847c1b9f7420783ec27dd438244e..b386ffca433ed6a49b76147758857d1a4f84caba vpc/outputs.tf

# see history for current file
  :DiffviewFileHistory %

# nice flow
  1. open diffview
  2. select a file then "gf" to open it in previous tab
  3. :DiffviewFileHistory %

}}}

{{{ telescope

- TAB - mark an item
- CTRL+Q - open ALL items in a quick list
- ALT+Q  - open marked items in a quick list

-- search syntax for FZF ~> https://github.com/junegunn/fzf#search-syntax
- one simple example is: `!foobar` - items that do not include `foobar`

}}}

{{{ mason
-- keybindings
<CR>  : toggle_package_expand
i     : install_package
u     : update_package
c     : check_package_version
U     : update_all_packages
C     : check_outdated_packages
X     : uninstall_package
}}}

{{{ nvim-tree
-- keybindings
E     : expand all
W     : collaps all
H     : toggle .dot files
J     : last sibling
K     : first sibling
P     : parent
m     : mark
bd    : delete marked
}}}

{{{ :!execute a command
:!ls        # executes a command `ls` and puts the output to a tmp buffer
:.!ls       # executes a command `ls` and puts the output to THE CURRENT BUFFER

# visual select a line(s) the !<command> # this will take the selected lines as an input to <command>
# handy example is to use `jq` to format single line json to pretty printed
# {"ok": "thisisnotformatedjson"}
# :'<,'>!jq
}}}

-- how to disable/enable diagnostics
    :lua vim.diagnostic.disable()
    :lua vim.diagnostic.enable()
--]]
-- }}}
