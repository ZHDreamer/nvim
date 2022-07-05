local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<ESC>'] = actions.close,
                ['<C-u>'] = actions.move_selection_previous,
                ['<C-e>'] = actions.move_selection_next
            },
            n = {
                ['u'] = actions.move_selection_previous,
                ['e'] = actions.move_selection_next
            }
        }
    }
})

-- 查找文件
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true <CR>')
-- 查找文字
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep <CR>')
-- 查找特殊符号
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers <CR>')
-- 查找帮助文档
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags <CR>')
-- 查找最近打开的文件
vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles <CR>')
-- 查找 marks 标记
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope marks <CR>')
