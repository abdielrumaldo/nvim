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
  end
}

return M
