local M = {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',

    config = function()
        local ts = require("nvim-treesitter")
        ts.setup({
            install = {
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
            }
        })
    end,
}
return M
