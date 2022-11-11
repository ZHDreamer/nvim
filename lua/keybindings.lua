-- Remap leader key
vim.keymap.set('', '<space>', '<nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- curser movement for colemak
vim.keymap.set('', 'h', 'h') -- left
vim.keymap.set('', 'i', 'l') -- right
if vim.g.vscode then
    vim.keymap.set(
        'n',
        'e',
        '<cmd>call VSCodeNotify("cursorMove", { "to": "up", "by": "wrappedLine", "value": v:count ? v:count : 1 })<CR>'
    ) -- up
    vim.keymap.set(
        'n',
        'n',
        '<cmd>call VSCodeNotify("cursorMove", { "to": "down", "by": "wrappedLine", "value": v:count ? v:count : 1 })<CR>'
    ) -- down
else
    vim.keymap.set('n', 'e', 'gk') -- up
    vim.keymap.set('n', 'n', 'gj') -- down
end
vim.keymap.set({ 'v', 'o' }, 'e', 'k') -- up
vim.keymap.set({ 'v', 'o' }, 'n', 'j') -- down
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'I', '$')
vim.keymap.set('n', 'E', '5e', { remap = true })
vim.keymap.set('n', 'N', '5n', { remap = true })
vim.keymap.set({ 'v', 'o' }, 'E', '5k') -- up
vim.keymap.set({ 'v', 'o' }, 'N', '5j') -- down

vim.keymap.set('', 'l', 'i') -- k for insert
vim.keymap.set('', 'L', 'I')
vim.keymap.set('n', 'gl', 'gi')
-- vim.keymap.set('n', 'l', 'u') -- l for undo

-- Split windows
vim.keymap.set('n', '<leader>h', ':split<CR>')
vim.keymap.set('n', '<leader>v', ':vsplit<CR>')

-- Window navigation
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-i>', '<C-w>l')
vim.keymap.set('n', '<A-e>', '<C-w>k')
vim.keymap.set('n', '<A-n>', '<C-w>j')

-- Window resize
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')

-- Search
vim.keymap.set('n', 'J', 'Nzz') -- previous search item
vim.keymap.set('n', 'j', 'nzz') -- next search item
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>') -- cancel search highlight

-- Dot repeat for visual mode
vim.keymap.set('v', '.', ':normal! .<CR>')

--
-- Custom operator-pending key
--
-- tex $ support
vim.keymap.set('o', 'lo', ':<C-u>normal! T$vt$<CR>')
vim.keymap.set('o', 'ao', ':<C-u>normal! F$vf$<CR>')
vim.keymap.set('v', 'lo', 'T$ot$')
vim.keymap.set('v', 'ao', 'F$of$')

vim.keymap.set({ 'v', 'o' }, 'le', 'i(')
vim.keymap.set({ 'v', 'o' }, 'ae', 'a(')
vim.keymap.set({ 'v', 'o' }, 'lu', 'i{')
vim.keymap.set({ 'v', 'o' }, 'au', 'a{')
vim.keymap.set({ 'v', 'o' }, 'l,', 'i[')
vim.keymap.set({ 'v', 'o' }, 'a,', 'a[')
vim.keymap.set({ 'v', 'o' }, 'lw', 'iw')
vim.keymap.set({ 'v', 'o' }, 'lW', 'iW')

-- tabs
-- vim.keymap.set('n', '<leader>t', '<cmd>tabnew<CR>') -- creat new tab
-- vim.keymap.set('n', '<Tab>', '<cmd>tabn<CR>') -- tab to next tab
-- vim.keymap.set('n', '<S-Tab>', '<cmd>tabp<CR>') -- shift + tab to previous tab
-- vim.keymap.set('n', '<Tab>', '>>')

-- vim.keymap.set('n', 'R', ':e<CR>')
-- vim.keymap.set('n', '<C-s>', ':w<CR>')

-- vim.keymap.set('n', '<Enter>', 'A<Enter><esc>')

-- vim.cmd([[
-- function AutoTab()
--     let line = getline('.')
--     let col = col('.')
--     if line[col - 2] == ' ' && line[col - 3] == '-'
--         return "\<Left>\<Left>\<Tab>\<Right>\<Right>"
--     else
--         return "\<Tab>"
--     endif
-- endf
-- ]])

-- vim.keymap.set('i', '<Tab>', '<C-r>=AutoTab()<CR>')

-- Indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- VSCode
if vim.g.vscode then
    vim.keymap.set({ 'n', 'i' }, '<c-p>', '<cmd>call VSCodeNotify("editor.action.triggerParameterHints")<cr>')
end
