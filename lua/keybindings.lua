-- Remap leader key
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- curser movement for colemak
vim.keymap.set("", "n", "h", { silent = true }) -- left
vim.keymap.set("", "i", "l", { silent = true }) -- right
vim.keymap.set("n", "u", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- up
vim.keymap.set("n", "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- down
vim.keymap.set({ "v", "o" }, "u", "k") -- up
vim.keymap.set({ "v", "o" }, "e", "j") -- down
vim.keymap.set("", "m", "^")
vim.keymap.set("", "o", "$")
vim.keymap.set("n", "U", "5u", { remap = true })
vim.keymap.set("n", "E", "5e", { remap = true })
vim.keymap.set({ "v", "o" }, "U", "5k") -- up
vim.keymap.set({ "v", "o" }, "E", "5j") -- down

-- vim.keymap.set('', 'h', 'g')
-- vim.keymap.set('', 'mm', 'gg')
-- vim.keymap.set('', 'H', 'G')

vim.keymap.set("", "h", "b")
vim.keymap.set("", "H", "B")
vim.keymap.set("", ".", "e")
vim.keymap.set("", ">", "E")

vim.keymap.set("", "l", "F")
vim.keymap.set("", "y", "f")
vim.keymap.set("", "L", "T")
vim.keymap.set("", "Y", "t")

vim.keymap.set("n", "O", "<C-i>") -- jump in
vim.keymap.set("n", "M", "<C-o>") -- jump out

-- insert mode
vim.keymap.set("", "a", "i")
vim.keymap.set("", "A", "I")
vim.keymap.set("", "s", "o")
vim.keymap.set("", "S", "O")
vim.keymap.set("", "t", "a")
vim.keymap.set("", "T", "A")

vim.keymap.set("n", "gt", "gi")

-- visual mode
vim.keymap.set("", "w", "v")
vim.keymap.set("", "W", "V")
vim.keymap.set("", "<C-w>", "<C-v>")

-- modify
vim.keymap.set("n", "v", "u")
vim.keymap.set("n", "V", "<C-r>")

vim.keymap.set("v", "v", "u")
vim.keymap.set("v", "V", "U")

vim.keymap.set("", "f", "y")
vim.keymap.set("v", "p", "pgvy")

-- Split windows
vim.keymap.set("n", "<leader>h", ":split<CR>")
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")

-- Window navigation
vim.keymap.set("n", "<C-n>", "<C-w>h")
vim.keymap.set("n", "<C-i>", "<C-w>l")
vim.keymap.set("n", "<C-u>", "<C-w>k")
vim.keymap.set("n", "<C-e>", "<C-w>j")

-- Window resize
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")

-- Search
vim.keymap.set("n", "N", "Nzz") -- previous search item
vim.keymap.set("n", "I", "nzz") -- next search item
vim.keymap.set("n", "k", "/")
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>") -- cancel search highlight
vim.keymap.set("n", "gi", "gn", { desc = "select next search item" })
vim.keymap.set("n", "gn", "gN", { desc = "select prev search item" })
vim.keymap.set("n", "cgi", "cgn", { desc = "change next search item" })
vim.keymap.set("n", "cgn", "cgN", { desc = "change prev search item" })

-- Dot repeat for visual mode
vim.keymap.set("", "/", ".")
vim.keymap.set("v", "/", ":normal! .<CR>")

-- quit uneditable buffer using q
local quit = vim.api.nvim_create_augroup("QuitUnmodifiable", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "help", "startuptime", "qf", "lspinfo", "notify" },
    group = quit,
    callback = function()
        vim.keymap.set("n", "q", "<cmd>bd<CR>", { buffer = true })
    end,
})

--
-- Custom operator-pending key
--
-- tex $ support
vim.keymap.set("o", "l$", ":<C-u>normal! T$vt$<CR>")
vim.keymap.set("o", "a$", ":<C-u>normal! F$vf$<CR>")
vim.keymap.set("v", "l$", "T$ot$")
vim.keymap.set("v", "a$", "F$of$")

-- vim.keymap.set({ "v", "o" }, "te", "i(")
-- vim.keymap.set({ "v", "o" }, "ae", "a(")
-- vim.keymap.set({ "v", "o" }, "tu", "i{")
-- vim.keymap.set({ "v", "o" }, "au", "a{")
-- vim.keymap.set({ "v", "o" }, "t,", "i[")
-- vim.keymap.set({ "v", "o" }, "a,", "a[")
vim.keymap.set({ "v", "o" }, "tw", "iw")
vim.keymap.set({ "v", "o" }, "tW", "iW")

-- Sortcuts
vim.keymap.set({ "n" }, "<M-a>", "ggVG")

-- tabs
-- vim.keymap.set('n', '<leader>t', '<cmd>tabnew<CR>') -- creat new tab
-- vim.keymap.set('n', '<Tab>', '<cmd>tabn<CR>') -- tab to next tab
-- vim.keymap.set('n', '<S-Tab>', '<cmd>tabp<CR>') -- shift + tab to previous tab
-- vim.keymap.set('n', '<Tab>', '>>')

-- vim.keymap.set('n', 'R', ':e<CR>')
-- vim.keymap.set('n', '<C-s>', ':w<CR>')

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
vim.keymap.set("n", "<c-t>", ">", { silent = true })
vim.keymap.set("n", "<c-t><c-t>", ">>", { silent = true })
vim.keymap.set("v", "<c-t>", ">gv", { silent = true })
vim.keymap.set("n", "<c-d>", ">", { silent = true })
vim.keymap.set("n", "<c-d><c-d>", "<<", { silent = true })
vim.keymap.set("v", "<c-d>", "<gv", { silent = true })

if vim.g.vscode then
    vim.keymap.set(
        "n",
        "u",
        '<cmd>call VSCodeNotify("cursorMove", { "to": "up", "by": v:count ? "line" : "wrappedLine", "value": v:count ? v:count : 1 })<cr>'
    ) -- up
    vim.keymap.set(
        "n",
        "e",
        '<cmd>call VSCodeNotify("cursorMove", { "to": "down", "by": v:count ? "line" : "wrappedLine", "value": v:count ? v:count : 1 })<cr>'
    ) -- down

    -- Prameter hints
    vim.keymap.set({ "n", "i" }, "<c-p>", '<cmd>call VSCodeNotify("editor.action.triggerParameterHints")<cr>')
    -- Comment line
    vim.keymap.set("", "C", '<cmd>call VSCodeNotify("editor.action.commentLine", 0)<cr>')
    -- Go file
    vim.keymap.set("n", "<leader>ff", '<cmd>call VSCodeNotify("workbench.action.quickOpen")<cr>')
end
