local highlight = {
    "IndentBackLineChar1",
    "IndentBackLineChar2",
    "IndentBackLineChar3",
}

local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IndentBackLineChar1", { fg = "#FFD700", sp = "#FFD700" })
    vim.api.nvim_set_hl(0, "IndentBackLineChar2", { fg = "#DA70D6", sp = "#DA70D6" })
    vim.api.nvim_set_hl(0, "IndentBackLineChar3", { fg = "#87CEFA", sp = "#87CEFA" })
end)

require("ibl").setup({
    enabled = true,
    debounce = 100,
    indent = {
        char = "▏",
        -- highlight = highlight,
        smart_indent_cap = true,
    },
    whitespace = { highlight = { "Whitespace", "NonText" } },
    scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        show_exact_scope = false,
        injected_languages = true,
        highlight = highlight,
        priority = 1024,
    },
})
