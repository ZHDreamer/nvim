local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format {
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == 'null-ls'
        end,
        bufnr = bufnr,
    }
end

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
                    lsp_formatting(bufnr)
                end,
            })
        end
    end,
}
