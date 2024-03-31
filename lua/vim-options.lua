-- Custom Spacing Preferences
--

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

-- gives you some context under curb
vim.opt.scrolloff = 10

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.diagnostic.config {
  float = { border = "rounded" }, -- add border to diagnostic popups
}

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Some spacing stuffs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

-- Keymaps
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep , {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers , {})

-- LSP
vim.keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- Look into this, why not just a map for both? {i, n}
vim.keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
vim.keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')

vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')
