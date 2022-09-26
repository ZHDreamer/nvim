local mason = require('mason-lspconfig')
local lspconfig = require('lspconfig')

local register_key = function(bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
    -- vim.keymap.set('n', '<space>d', '<cmd>lua vim.diagnostic.open_float({ border = "single" })<cr>', opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', 'H', '<cmd>lua vim.lsp.buf.hover(opts = { border = "single" })<cr>', opts)
    -- vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
end

vim.diagnostic.config({
    signs = true,
    underline = true,
    severity_sort = true,
    update_in_insert = true,
    float = { source = 'always', border = 'single' },
    virtual_text = { prefix = '●', source = 'if_many' },
})

local signs = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = ' ',
}

for _type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. _type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local conf_dir = 'lsp.'

for _, server_name in ipairs(mason.get_installed_servers()) do
    local conf_path = string.format('%s%s', conf_dir, server_name)

    local ok, settings = pcall(require, conf_path)

    if not ok then
        settings = {}
    end

    settings.on_attach = function(client, bufnr)
        register_key(bufnr)
    end

    lspconfig[server_name].setup(settings)
end
