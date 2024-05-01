local M = {
    "mfussenegger/nvim-lint",
    event = {},
    config = function()
        local lint = require("nvim-lint");

        lint.lint_by_ft = {
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            vue = { "eslint_d" },
            json = { "eslint_d" },
            yaml = { "eslint_d" },
            markdown = { "eslint_d" },
            graphql = { "eslint_d" },
            liquid = { "eslint_d" },
            -- Conform will run multiple formatters sequentially
            python = { "pylint" },
            -- Use a sub-list to run only the first available formatter
            javascript = { "eslint_d" },

        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end
        })
        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end)
    end
}

return M
