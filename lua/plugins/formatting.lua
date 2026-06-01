local M = {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "deno_fmt" },
                typescript = { "deno_fmt" },
                markdown = { "deno_fmt" },
                dockerfile = { "dockerfmt" },
                css = { "css_beautify" },
                html = { "html_beautify" },
                json = { "jq" },
                yaml = { "yamlfmt" },
                jinja = { "djlint" },
                python = { "ruff_format", "ruff_organize_imports", "ruff_fix", lsp_format = "last" },
            },

            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 10000,
            },
            notify_on_error = true,
        })
    end,
}
return M
