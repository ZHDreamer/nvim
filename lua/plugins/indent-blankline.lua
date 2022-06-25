require('indent_blankline').setup{
    enabled = true,
    disable_with_nolist = true,
    char = '▏',
    char_blankline = '▏',
    space_char_blankline = ' ',
    context_char = '▏',
    context_char_blankline = '▏',
    show_trailing_blankline_indent = false,
    indent_level = 10,
    max_indent_increase = 2,
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = false,
    context_patterns = {
        "class",
        "^func",
        "method",
        "^if",
        "while",
        "for",
        "with",
        "try",
        "except",
        "arguments",
        "argument_list",
        "object",
        "dictionary",
        "element",
        "table",
        "tuple",
        "do_block",
        'constructor'
    },
    use_treesitter = false,
    use_treesitter_scope = false,
}

vim.cmd([[highlight IndentBlanklineContextChar guifg=#DA70D6 gui=nocombine cterm=nocombine]])
