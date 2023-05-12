local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
            -- return true
        end,
        bufnr = bufnr,
    })
end

null_ls.setup({
    debug = true,
    sources = {
        formatting.stylua.with({
            condition = function(utils)
                return not utils.root_has_file({ "stylua.toml", ".stylua.toml" })
            end,
            extra_args = {
                "--call-parentheses=Always",
                "--collapse-simple-statement=Never",
                "--indent-type=Spaces",
                "--indent-width=4",
                "--line-endings=Unix",
                "--quote-style=AutoPreferSingle",
            },
        }),
        formatting.stylua.with({
            condition = function(utils)
                return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
            end,
        }),
        formatting.black.with({
            extra_args = {
                "--skip-string-normalization",
            },
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end,
})
