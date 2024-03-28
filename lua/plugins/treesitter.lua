local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {"lua", "javascript", "vim", "vimdoc", "python", "go", "bash", "json", "yaml", "vue", "toml", "sql", "regex"},
      highlight = {enable = true},
      indent = {enable = true},
    })
    end
  }

return M
