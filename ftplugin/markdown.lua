vim.bo.expandtab = true  -- replace tab with space
local tabs = 2           -- how many spaces replace tab
vim.bo.tabstop = tabs    -- Number of spaces that a <Tab> in the file counts for
vim.bo.softtabstop = tabs-- Number of spaces that a <Tab> counts for convertint tab to space
vim.bo.shiftwidth = tabs

vim.bo.smartindent = true
