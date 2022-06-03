-- style
vim.opt.termguicolors = true -- embed 24-bit color in nvim
-- line style
vim.opt.number = true  -- show line number
vim.opt.relativenumber = true  -- show relative line number
vim.opt.cursorline = true  -- show cursor line
vim.opt.wrap = true    -- auto wrap long line
vim.opt.scrolloff = 10  -- keep n lines on scroll vertical

-- show tab and trail space
vim.opt.list = true
vim.opt.listchars:append("trail:⋅")
vim.opt.listchars:append("tab:--")

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- auto indent
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.filetype = 'plugin'

-- system
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
if vim.fn.has('wsl') then
    vim.cmd [[
    augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
    augroup END
    ]]
end
vim.opt.mouse = 'a'               -- enable mouse
