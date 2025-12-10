local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdateSync",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"toml",
				"bash",
				"go",
				"html",
				"css",
				"scss",
				"sql",
				"regex",
				"markdown",
				"markdown_inline",
				"vue",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
return M
