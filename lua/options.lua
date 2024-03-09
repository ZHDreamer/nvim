-- style
vim.opt.termguicolors = true -- embed 24-bit color in nvim
vim.opt.laststatus = 3
vim.opt.showmode = false -- don't show mode because we have statusline
-- line style
vim.opt.number = true -- show line number
vim.opt.relativenumber = true -- show relative line number
-- Auto toggle relative line number when lost focus
-- https://github.com/jeffkreeftmeijer/vim-numbertoggle
-- set -g focus-events on in tmux.conf to trigger focus event
vim.opt.signcolumn = "yes:1"
vim.opt.fillchars = "eob: " -- remove the ugly ~ at end of buffer
vim.opt.wrap = true -- auto wrap long line
vim.opt.scrolloff = 0 -- keep n lines on scroll vertical

vim.opt.cursorline = true -- show cursor line
vim.cmd([[
    set guicursor=n-v-ve:block,i-c-ci-cr:ver2,r-o:hor2
]])
vim.cmd([[autocmd VimLeave * set guicursor=a:ver2-blinkon500]])
-- show tab and trail space
vim.opt.list = true
vim.opt.listchars:append("trail:⋅")
vim.opt.listchars:append("tab:>-")

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true -- tab will align with indent length
vim.opt.expandtab = true -- replace tab with space
local tabs = 4 -- how many spaces replace tab
vim.opt.tabstop = tabs
vim.opt.softtabstop = tabs
vim.opt.shiftwidth = tabs
vim.opt.shiftround = true -- <, >, <C-d>, <C-t> will align with indent length
-- vim.opt.filetype = 'plugin'

-- system
vim.opt.clipboard = "unnamed" -- use system clipboard
vim.opt.mouse = "a" -- enable mouse
vim.opt.undofile = true -- keep undo history

-- EOL and EOF
vim.opt.fileformat = "unix"
vim.opt.endofline = true
vim.opt.endofline = true

vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.confirm = true -- confirm when quit without save
-- vim.cmd[[ au BufLeave * silent w ]] -- Autowrite when moving between buffers

-- Don't creat comment when adding new line after a comment
-- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
-- vim.opt.formatopitons = "jqlnt"

-- vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.python3_host_prog = "C:/Users/ZHDreamer/scoop/shims/python3"

local disable_builtin_plugins = {
    -- "netrw",
    -- "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, builtin_plugin in ipairs(disable_builtin_plugins) do
    vim.g["loaded_" .. builtin_plugin] = 1
end

vim.g.loaded_matchparen = 0

local M = {}

M.border = "rounded"

return M
