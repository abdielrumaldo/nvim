local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
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
                "basedpyright",
                "ruff",
                "jsonls",
                "html",
                "cssls",
                "yamlls",
                "bashls",
                "lemminx",
                "marksman",
                "eslint",
            },
            automatic_installation = true,
        })


        local caps = require("cmp_nvim_lsp").default_capabilities()

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
        -- Define servers using vim.lsp.config(...)

        vim.lsp.config("lua_ls", {
            name = "lua_ls",
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            capabilities = caps,
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
            capabilities = caps,
            init_options = { settings = { args = {} } },
        })


        vim.lsp.config("html", {
            name = "html",
            cmd = { "vscode-html-language-server", "--stdio" },
            filetypes = { "html", "vue" },
            capabilities = caps,
        })

        vim.lsp.config("eslint", {
            name = "eslint",
            cmd = { "vscode-eslint-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
            capabilities = caps,
        })


        -- Optionally configure extra servers (installed by Mason)
        vim.lsp.config("jsonls", {
            name = "jsonls",
            cmd = { "vscode-json-language-server", "--stdio" },
            filetypes = { "json", "jsonc" },
            capabilities = caps,
        })
        vim.lsp.config("cssls", {
            name = "cssls",
            cmd = { "vscode-css-language-server", "--stdio" },
            filetypes = { "css", "scss", "less" },
            capabilities = caps,
        })
        vim.lsp.config("yamlls", {
            name = "yamlls",
            cmd = { "yaml-language-server", "--stdio" },
            filetypes = { "yaml", "yml" },
            capabilities = caps,
        })
        vim.lsp.config("bashls", {
            name = "bashls",
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            capabilities = caps,
        })
        vim.lsp.config("lemminx", {
            name = "lemminx",
            cmd = { "lemminx" },
            filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
            capabilities = caps,
        })
        vim.lsp.config("marksman", {
            name = "marksman",
            cmd = { "marksman", "server" },
            filetypes = { "markdown" },
            capabilities = caps,
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
        vim.lsp.enable("vtsls")
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("basedpyright")
        vim.lsp.enable("ruff")
        vim.lsp.enable("html")
        vim.lsp.enable("eslint")
        vim.lsp.enable("jsonls")
        vim.lsp.enable("cssls")
        vim.lsp.enable("yamlls")
        vim.lsp.enable("bashls")
        vim.lsp.enable("lemminx")
        vim.lsp.enable("marksman")
        vim.lsp.enable("vue_ls")
    end,
}

return M
