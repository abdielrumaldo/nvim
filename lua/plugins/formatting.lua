local M = {
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                svelte = { "prettier" },
                vue = { "prettier" },
                css = { "prettier" },
                htmldjango = { "djlint", lsp_format = 'fallback' },
                html = { "djlint", lsp_format = 'fallback' },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                -- Conform will run multiple formatters sequentially
                python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
                -- Use a sub-list to run only the first available formatter
                javascript = { "prettierd" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout = 500,
            },
        })
    end,
}
return M
