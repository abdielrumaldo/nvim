-- npm install -g eslint_d eslint stylelint markdownlint-cli graphql-schema-linter theme-check
-- pip3 install ruff djlint yamllint
-- brew install shellcheck
-- For xml/json linters if needed: brew install libxml2; npm install -g jsonlint
local M = {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- Helper: check if ESLint config exists in the project
        local function has_eslint_config(bufnr)
            local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
            local cfg = vim.fs.find({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.mjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
                "package.json",
            }, { upward = true, path = dir, type = "file" })[1]
            if not cfg then return false end
            if cfg:match("package.json") then
                local ok, json = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(cfg), "\n"))
                return ok and json and json.eslintConfig ~= nil
            end
            return true
        end

        -- Prefer eslint_d, fallback to eslint, only if config is present
        local function should_run_eslint(ft, bufnr)
            if ft == "javascript" or ft == "typescript" or ft == "javascriptreact"
                or ft == "typescriptreact" or ft == "vue" or ft == "svelte"
            then
                return has_eslint_config(bufnr)
            end
            return true
        end

        lint.linters_by_ft = {
            -- JS/TS ecosystem
            javascript = { "eslint_d", "eslint" },
            typescript = { "eslint_d", "eslint" },
            javascriptreact = { "eslint_d", "eslint" },
            typescriptreact = { "eslint_d", "eslint" },
            vue = { "eslint_d", "eslint" },
            svelte = { "eslint_d", "eslint" },

            -- Web/markup
            html = { "djlint" }, -- also formats via Conform
            htmldjango = { "djlint" },
            css = { "stylelint" },
            json = { "jsonlint" },
            yaml = { "yamllint" },
            markdown = { "markdownlint" },
            graphql = { "graphql_schema_linter" },
            liquid = { "theme_check" }, -- Shopify Liquid

            -- Others from LSP list
            bash = { "shellcheck" },
            xml = { "xmllint" }, -- for lemminx filetypes
            python = { "ruff" },
        }

        -- Filtered lint runner: skip ESLint when no config
        local function try_lint_filtered()
            local bufnr = vim.api.nvim_get_current_buf()
            local ft = vim.bo[bufnr].filetype
            local linters = lint.linters_by_ft[ft]
            if not linters or #linters == 0 then return end

            if not should_run_eslint(ft, bufnr) then
                -- Temporarily disable ESLint linters for this run
                local filtered = vim.tbl_filter(function(name)
                    return name ~= "eslint" and name ~= "eslint_d"
                end, linters)
                if #filtered == 0 then return end
                lint.try_lint(filtered)
                return
            end

            lint.try_lint()
        end

        local grp = vim.api.nvim_create_augroup("UserLint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = grp,
            callback = try_lint_filtered,
        })

        vim.keymap.set("n", "<leader>l", try_lint_filtered, { desc = "Lint current file" })
    end,
}
return M
