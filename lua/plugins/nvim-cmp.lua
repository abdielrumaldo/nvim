local M = {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-buffer',       -- Text in the buffed
        'hrsh7th/cmp-path',         -- source for file paths
        'L3MON4D3/LuaSnip',         -- snippet engine
        'saadparwaiz1/cmp_luasnip', -- autocomplete for the snippet
        'rafamadriz/friendly-snippets'
    },
    config = function()
        local cmp = require("cmp")
        local lua_snip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect,noinsert",
            },
            snippet = { -- How nvim-cmp interacts with snippet engine
                expand = function(args)
                    lua_snip.lsp_expand(args.body)
                end
            },
            mapping= cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim-lsp" }, -- Order does determine prio
                { name = "luasnip" }, -- Order does determine prio
                { name = "buffer" },
                { name = "path" },
            })
        }

        )
    end
}

return M
