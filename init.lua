-- Go get Lazy if it doesn't exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
local opts = {}

-- This has to be set before initializing lazy
vim.g.mapleader = " "

require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } }, {
    change_detection = {
        enabled = true, -- automatically check for config file changes and reload the ui
        notify = false, -- turn off notifications whenever plugin changes are made
    },
})

-- Treesitter doesn't work with the new filetype system, so we have to start it manually for each filetype
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'python', 'javascript', 'typescript', 'rust', 'go' },
    callback = function() vim.treesitter.start() end,
})

-- sigh... always do this last...
require("vim-options")
require("filetypes")
