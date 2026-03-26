local M = {
    'cachebag/nvim-tcss',
    config = function()
        require('tcss').setup({
            enable = true,
        })
    end
}

return M
