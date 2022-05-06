local keymap = vim.keymap.set

-- curser movement for colemak
keymap('', 'n', 'h') -- left
keymap({'n', 'v'}, 'i', 'l') -- right
keymap('', 'u', 'k') -- up
keymap('', 'e', 'j') -- down
keymap('', 'N', '^')
keymap('', 'NN', '0')
keymap('', 'I', '$')
keymap('', 'U', '5k')
keymap('', 'E', '5j')
keymap('n', '-', 'Nzz')
keymap('n', '=', 'nzz')

keymap('', 'k', 'i') -- k for insert
keymap('', 'K', 'I')
keymap('n', 'l', 'u') -- l for undo
keymap('n', 'L', 'U')

-- Split windows
keymap('n', '<leader>h', ':split<CR>')
keymap('n', '<leader>v', ':vsplit<CR>')

-- Window navigation
keymap('n', '<c-n>', "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>")
keymap('n', '<c-i>', "<cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>")
keymap('n', '<c-u>', "<cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>")
keymap('n', '<c-e>', "<cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>")

-- Window resize
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")

keymap('n', '<Enter>', 'A<CR><esc>')

keymap('n', '<A-3>', '<cmd>call VSCodeNotify("workbench.action.firstEditorInGroup")<CR><cmd>call VSCodeNotify("workkench.action.nextEditorInGroup")<CR>')
