local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local formatting = null_ls.builtins.formatting

null_ls.setup {
    debug = false,
    sources = {
        formatting.stylua.with {
            -- extra_args = {
            --     '--call-parentheses NoSingleString',
            --     '--indent-type Spaces',
            --     '--quote-stlue AutoPreferSingle',
            -- },
        },
        formatting.black.with {
            extra_args = {
                '--skip-string-normalization',
            },
        },
    },
    on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
}
