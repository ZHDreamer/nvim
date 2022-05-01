vim.bo.expandtab = true  -- replace tab with space
local tabs = 4           -- how many spaces replace tab
vim.bo.tabstop = tabs
vim.bo.softtabstop = tabs
vim.bo.shiftwidth = tabs

vim.opt_local.formatoptions = vim.opt_local.formatoptions - {'c', 'r', 'o'}
