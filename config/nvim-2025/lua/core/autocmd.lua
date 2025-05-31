--
-- some quick and nice autocommands
--
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.nomadtpl", command = "set filetype=hcl" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.nomad.j2", command = "set filetype=hcl" })
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ pattern = "docker-compose.y*ml.*", command = "set filetype=docker-compose" }
)

vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = "*", command = [[%s/\s\+$//e]] }) -- remove trailing white spaces
