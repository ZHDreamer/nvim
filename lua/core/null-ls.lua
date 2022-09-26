local null_ls = require('null-ls')

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
    },
}
