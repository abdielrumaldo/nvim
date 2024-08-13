local M = {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            -- Install these LSPs automatically
            ensure_installed = {
                'bashls',   -- requires npm to be installed
                'cssls',    -- requires npm to be installed
                'html',     -- requires npm to be installed
                'lua_ls',
                'jsonls',   -- requires npm to be installed
                'tsserver', -- requires npm to be installed
                'yamlls',   -- requires npm to be installed
                'lemminx',
                'marksman',
                'quick_lint_js',
                'yamlls',
                'pyright',
            },
            automatic_installation = true,
        })
    end
}

return M
