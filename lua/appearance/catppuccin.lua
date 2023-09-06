-- https://github.com/catppuccin/nvim

vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    term_colors = false,
    compile = {
        enabled = false,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = false,
        },
        coc_nvim = false,
        lsp_trouble = true,
        cmp = true,
        lsp_saga = true,
        gitgutter = false,
        gitsigns = false,
        leap = false,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        neotree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
        },
        dap = {
            enabled = false,
            enable_ui = false,
        },
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = false,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        markdown = false,
        lightspeed = false,
        ts_rainbow = false,
        hop = true,
        notify = true,
        telekasten = false,
        symbols_outline = false,
        mini = false,
        aerial = false,
        vimwiki = false,
        beacon = false,
    },
    color_overrides = {},
    custom_highlights = {
        NormalFloat = { bg = colors.base }, -- set the floating window bg
        FloatBorder = { fg = colors.surface1 },
        gitBranch = { fg = "#F3F99D" },
        diffAdded = { fg = colors.green }, -- diff mode: Added line |diff.txt|
        diffChanged = { fg = colors.blue }, -- diff mode: Changed line |diff.txt|
        diffRemoved = { fg = colors.red }, -- diff mode: Deleted line |diff.txt|
    },
})
