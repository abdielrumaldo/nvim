local M = {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        return require "plugins.configs.nvim-tree"
    end,
    config = function(_, opts)
        vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {})
        require("nvim-tree").setup(opts)
        vim.cmd [[
        autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
        \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

        ]]
    end
}

return M
