return {
	{
		-- https://github.com/moll/vim-bbye
		-- symlink dependency, required in order to symlink work properly in diff mode
		"moll/vim-bbye",
	},
	{
		-- https://github.com/aymericbeaumet/vim-symlink
		-- deals with symlinks correctly
		"aymericbeaumet/vim-symlink",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
