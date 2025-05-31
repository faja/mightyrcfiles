-- TODO:
-- plugins related
-- cmp
-- vim.opt.completeopt = { "menuone", "noselect" }         -- for cmp, from lunar
-- vim.opt.completeopt = { "menu", "menuone", "noselect" } -- for cmp, my old
--
-- TODO:
-- old LSP plugins still to check if valid
-- use "onsails/lspkind-nvim"              -- https://github.com/onsails/lspkind-nvim -- this is for autocompletion
-- use "ray-x/lsp_signature.nvim"          -- https://github.com/ray-x/lsp_signature.nvim -- this is also for autocompletion
--
-- TODO:
-- require("lsp_signature").setup({
-- 	toggle_key = "<M-x>",
-- })

return {
	{
		-- https://github.com/saghen/blink.cmp
		"saghen/blink.cmp",
	},
}
