-- https://github.com/rcarriga/nvim-notify#setup

vim.notify = require('notify')
vim.notify.setup({
    stages = 'fade_in_slide_out',
    timeout = 3000,
    fps = 60
})
