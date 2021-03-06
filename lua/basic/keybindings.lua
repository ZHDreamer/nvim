-- local keymap = function (...)
--   --get the extra options
--   local opts = { noremap = true, silent = true }
--   local keys = { ... }
--   for i, v in pairs(keys) do
--     if type(i) == 'string' then
--       opts[i] = v
--     end
--   end

--   -- basic support for buffer-scoped keybindings
--   local buffer = opts.buffer
--   opts.buffer = nil

--   if buffer then
--     vim.api.nvim_buf_set_keymap(0, keys[1], keys[2], keys[3], opts)
--   else
--     vim.api.nvim_set_keymap(keys[1], keys[2], keys[3], opts)
--   end
-- end
local keymap = vim.keymap.set

-- Remap leader key
keymap('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- curser movement for colemak
keymap('', 'n', 'h') -- left
keymap('', 'i', 'l') -- right
keymap('n', 'u', 'gk') -- up
keymap('n', 'e', 'gj') -- down
keymap({ 'v', 'o' }, 'u', 'k') -- up
keymap({ 'v', 'o' }, 'e', 'j') -- down
keymap('', 'N', '^')
keymap('', 'I', '$')
keymap('n', 'U', '5gk')
keymap('n', 'E', '5gj')

keymap('', 'k', 'i') -- k for insert
keymap('', 'K', 'I')
keymap('n', 'l', 'u') -- l for undo
keymap('n', 'L', 'U')

-- Split windows
keymap('n', '<leader>h', ':split<CR>')
keymap('n', '<leader>v', ':vsplit<CR>')

-- Window navigation
keymap('n', '<A-n>', '<C-w>h')
keymap('n', '<A-i>', '<C-w>l')
keymap('n', '<A-u>', '<C-w>k')
keymap('n', '<A-e>', '<C-w>j')

-- Window resize
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")

-- Search
keymap('n', 'J', 'Nzz') -- previous search item
keymap('n', 'j', 'nzz') -- next search item
keymap('n', '<ESC>', '<cmd>nohlsearch<CR>') -- cancel search highlight

-- tabs
-- keymap('n', '<leader>t', '<cmd>tabnew<CR>') -- creat new tab
-- keymap('n', '<Tab>', '<cmd>tabn<CR>') -- tab to next tab
-- keymap('n', '<S-Tab>', '<cmd>tabp<CR>') -- shift + tab to previous tab
-- keymap('n', '<Tab>', '>>')

keymap('n', 'R', ':e<CR>')
keymap('n', '<C-s>', ':w<CR>')

keymap('n', '<Enter>', 'A<Enter><esc>')

vim.cmd([[
function AutoTab()
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == ' ' && line[col - 3] == '-'
        return "\<Left>\<Left>\<Tab>\<Right>\<Right>"
    else
        return "\<Tab>"
    endif
endf
]])

keymap('i', '<Tab>', '<C-r>=AutoTab()<CR>')
keymap('i', '<C-t>', '<C-d>')
keymap('i', '<C-d>', '<C-t>')
