-- https://github.com/catppuccin/nvim
local catppuccin = require('catppuccin')

catppuccin.setup(
    {
        -- 透明背景
        transparent_background = false,
        -- 使用终端背景色
        term_color = true,
        -- 代码样式
        styles = {
            comments = 'NONE',
            functions = 'NONE',
            keywords = 'NONE',
            strings = 'NONE',
            variables = 'NONE'
        },
        -- 为不同的插件统一样式风格
        -- 尽管这里有一些插件还没有安装，但是先将它们
        -- 设置为 true 并不影响
        integrations = {
            cmp = true,
            gitsigns = true,
            telescope = true,
            which_key = true,
            bufferline = true,
            markdown = true,
            ts_rainbow = false,
            hop = true,
            notify = true,
            indent_blankline = {
                enabled = false,
                colored_indent_levels = false,
            },
            nvimtree = {
                enabled = true,
                show_root = false,
                -- 透明背景
                transparent_panel = true,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = 'italic',
                    hints = 'italic',
                    warnings = 'italic',
                    information = 'italic'
                },
                underlines = {
                    errors = 'underline',
                    hints = 'underline',
                    warnings = 'underline',
                    information = 'underline'
                }
            },
            -- 后面我们自己会手动设置
            lsp_saga = true
        }
    }
)

local colors = require('catppuccin.api.colors').get_colors()

catppuccin.remap({
    markdownH1         = { fg = colors.lavender },
    markdownH2         = { fg = colors.mauve },
    markdownH3         = { fg = colors.green },
    markdownH4         = { fg = colors.yellow },
    markdownH5         = { fg = colors.pink },
    markdownH6         = { fg = colors.teal },
    markdownItalic     = { fg = colors.peach, style = 'italic' },
    markdownBold       = { fg = colors.red, style = 'bold' },
    markdownBoldItalic = { fg = colors.red, style = 'bold,italic' },
    markdownCode       = { fg = colors.sapphire },
    markdownCodeBlock  = { fg = colors.sapphire },
})

local color_palette = {
    rosewater = "#F5E0DC",
    flamingo = "#F2CDCD",
    pink = "#F5C2E7",
    mauve = "#CBA6F7",
    red = "#F38BA8",
    maroon = "#EBA0AC",
    peach = "#FAB387",
    yellow = "#F9E2AF",
    green = "#A6E3A1",
    teal = "#94E2D5",
    sky = "#89DCEB",
    sapphire = "#74C7EC",
    blue = "#89B4FA",
    lavender = "#B4BEFE",

    text = "#CDD6F4",
    subtext1 = "#BAC2DE",
    subtext0 = "#A6ADC8",
    overlay2 = "#9399B2",
    overlay1 = "#7F849C",
    overlay0 = "#6C7086",
    surface2 = "#585B70",
    surface1 = "#45475A",
    surface0 = "#313244",

    base = "#1E1E2E",
    mantle = "#181825",
    crust = "#11111B",
}
