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
vim.opt.listchars:append('trail:⋅')
vim.opt.listchars:append('tab:>-')

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- auto indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true -- tab will align with indent length
vim.opt.expandtab = true  -- replace tab with space
local tabs = 4           -- how many spaces replace tab
vim.opt.tabstop = tabs
vim.opt.softtabstop = tabs
vim.opt.shiftwidth = tabs
vim.opt.shiftround = true -- <, >, <C-d>, <C-t> will align with indent length
-- vim.opt.filetype = 'plugin'

-- system
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
-- -- 
-- if vim.fn.has('wsl') then
--     vim.cmd [[
--         let s:clip = '/mnt/c/Windows/System32/clip.exe'
--         if executable(s:clip)
--             augroup WSLYank
--                 autocmd!
--                 autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
--             augroup END
--         endif
--     ]]
-- end

vim.opt.mouse = 'a'               -- enable mouse
