local M = {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        'rafamadriz/friendly-snippets',
        "fang2hou/blink-copilot",
        "nvim-mini/mini.icons",
        "onsails/lspkind.nvim"
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',

    opts = {
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        keymap = {
            preset = 'none',
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
        },
        completion = {
            list = {
                selection = { preselect = false, auto_insert = false }
            },
            documentation = { auto_show = true },
            ghost_text = {
                enabled = true,
            },
            -- Adds pretty icons to the completion menu
            menu = {
                direction_priority = function()
                    local ctx = require('blink.cmp').get_context()
                    local item = require('blink.cmp').get_selected_item()
                    if ctx == nil or item == nil then return { 's', 'n' } end

                    local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
                    local is_multi_line = item_text:find('\n') ~= nil

                    -- after showing the menu upwards, we want to maintain that direction
                    -- until we re-open the menu, so store the context id in a global variable
                    if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
                        vim.g.blink_cmp_upwards_ctx_id = ctx.id
                        return { 'n', 's' }
                    end
                    return { 's', 'n' }
                end,
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                if ctx.source_name ~= "Path" then
                                    return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
                                end

                                local is_unknown_type = vim.tbl_contains(
                                    { "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                                local mini_icon, _ = require("mini.icons").get(
                                    is_unknown_type and "os" or ctx.item.data.type,
                                    is_unknown_type and "" or ctx.label
                                )

                                return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
                            end,

                            highlight = function(ctx)
                                if ctx.source_name ~= "Path" then return ctx.kind_hl end

                                local is_unknown_type = vim.tbl_contains(
                                    { "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                                local mini_icon, mini_hl = require("mini.icons").get(
                                    is_unknown_type and "os" or ctx.item.data.type,
                                    is_unknown_type and "" or ctx.label
                                )
                                return mini_icon ~= nil and mini_hl or ctx.kind_hl
                            end,
                        }
                    }
                }
            }
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer',
                "copilot" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
        },
    },
    opts_extend = { "sources.default" }
}
return M
