local M = {
    'numToStr/Comment.nvim',
    opts = {
    },
    lazy = false,
    config = function ()
        require('Comment').setup()
    end
}

return M
