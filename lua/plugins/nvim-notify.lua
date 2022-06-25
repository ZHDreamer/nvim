local notify_opts = {
    stage = 'fade_in_slide_out',
    timeout = 2000
}

vim.notify = require('notify')
vim.notify.setup(notify_opts)
