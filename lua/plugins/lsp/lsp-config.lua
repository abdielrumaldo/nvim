local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'saghen/blink.cmp',
    },
    config = function()
        -- Mason setup + ensure servers
        require("mason").setup()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = {
                "vue_ls",
                "vtsls",
                "lua_ls",
                -- "basedpyright",
                "ruff",
                "jsonls",
                "html",
                "cssls",
                "yamlls",
                "bashls",
                "lemminx",
                "marksman",
                "eslint",
                'ty'
            },
            automatic_installation = true,
        })

        -- Autocomplete capabilities for all lsps
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        vim.lsp.config(
            "*",
            {
                capabilities = capabilities
            }
        )

        -- Inlay hints only if server supports them
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspInlayHints", { clear = true }),
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and client.server_capabilities and client.server_capabilities.inlayHintProvider then
                    local buf = ev.buf
                    if type(vim.lsp.inlay_hint) == "function" then
                        vim.lsp.inlay_hint(buf, true)
                    elseif type(vim.lsp.inlay_hint) == "table" and vim.lsp.inlay_hint.enable then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
                    end
                end
            end,
        })

        vim.lsp.config("lua_ls", {
            name = "lua_ls",
            cmd = { "lua-language-server" },
            filetypes = { "lua" },

            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
                    completion = { callSnippet = "Replace" },
                },
            },
        })

        vim.lsp.config("ruff", {
            name = "ruff",
            cmd = { "ruff", "server" },
            filetypes = { "python" },
            init_options = { settings = { args = {} } },
        })

        vim.lsp.config("html", {
            name = "html",
            cmd = { "vscode-html-language-server", "--stdio" },
            filetypes = { "html", "vue" },
        })

        vim.lsp.config("eslint", {
            name = "eslint",
            cmd = { "vscode-eslint-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
        })

        -- Optionally configure extra servers (installed by Mason)
        vim.lsp.config("jsonls", {
            name = "jsonls",
            cmd = { "vscode-json-language-server", "--stdio" },
            filetypes = { "json", "jsonc" },
        })

        vim.lsp.config("cssls", {
            name = "cssls",
            cmd = { "vscode-css-language-server", "--stdio" },
            filetypes = { "css", "scss", "less" },
        })

        vim.lsp.config("yamlls", {
            name = "yamlls",
            cmd = { "yaml-language-server", "--stdio" },
            filetypes = { "yaml", "yml" },
        })

        vim.lsp.config("bashls", {
            name = "bashls",
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
        })

        vim.lsp.config("lemminx", {
            name = "lemminx",
            cmd = { "lemminx" },
            filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },

        })

        vim.lsp.config("marksman", {
            name = "marksman",
            cmd = { "marksman", "server" },
            filetypes = { "markdown" },

        })

        vim.lsp.config('ty', {
            settings = {
                ty = {
                }
            }
        })
        -- vim.lsp.config("basedpyright", {
        --     settings = {
        --         basedpyright = {
        --             {
        --                 analysis = {
        --                     typeCheckingMode = 'basic'
        --                 }
        --             }
        --         },
        --     },
        -- })

        vim.lsp.config('cssls', {
            filetypes = { "tcss", "css", "scss", "less" }
        })

        local vue_language_server_path = vim.fn.stdpath("data")
            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
        local vue_plugin = {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
            configNamespace = "typescript",
        }

        vim.lsp.config("vtsls", {


            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            vue_plugin,
                        },
                    },
                },
            },
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        })
        -- Enable all defined servers
        vim.lsp.enable({ "vtsls",
            "cssls",
            "lua_ls",
            -- "basedpyright",
            "ruff",
            "html",
            "eslint",
            "jsonls",
            "cssls",
            "yamlls",
            "bashls",
            "lemminx",
            "marksman",
            "vue_ls",
            "ty"
        })
    end,
}

return M
