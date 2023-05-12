-- https://github.com/hrsh7th/nvim-cmp

local cmp = require("cmp")
local cmp_window = require("cmp.config.window")
local icons = require("icons")
local options = require("options")

local source_name = {
    buffer = "Buf",
    cmd = "CMD",
    copilot = "Copilot",
    nvim_lsp = "LSP",
    luasnip = "LuaSnip",
    nvim_lua = "Nvim",
    path = "Path",
    async_path = "Path",
    latex_symbols = "UniTeX",
}

for source, name in pairs(source_name) do
    source_name[source] = "[" .. name .. "]"
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp_window.bordered({ border = options.border }),
        doccompletion = cmp_window.bordered({ borders = options.border }),
        documentation = cmp_window.bordered({ border = options.border }),
    },
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "vsnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        {
            name = "path",
            option = {
                get_cwd = function(params)
                    return vim.fn.getcwd()
                end,
            },
        },
        { name = "buffer" },
        -- { name = 'cmdline' },
        { name = "spell" },
        { name = "latex_symbols" },
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = icons.Cmp[vim_item.kind]
            vim_item.menu = source_name[entry.source.name]
            return vim_item
        end,
    },

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    mapping = {
        ["<down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<tab>"] = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        ["<C-@>"] = cmp.mapping({
            i = function()
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end,
            c = function()
                if cmp.visible() then
                    cmp.close()
                else
                    cmp.complete()
                end
            end,
        }),
    },
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
    view = {
        entries = "custom",
    },
    formatting = {
        fields = { "abbr" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "async_path" },
    }, {
        { name = "cmdline" },
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s %s", icons.Cmp[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                cmdline = "[CMD]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
})
