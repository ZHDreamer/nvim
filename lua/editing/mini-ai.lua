local gen_spec = require('mini.ai').gen_spec

require('mini.ai').setup {
    -- Table with textobject id as fields, textobject specification as values.
    -- Also use this to disable builtin textobjects. See |MiniAi.config|.
    custom_textobjects = {
        ['e'] = { { '%b()', '%b[]', '%b{}' }, '^.%s*().-()%s*.$' },
        ['a'] = gen_spec.treesitter { a = '@parameter.outer', i = '@parameter.outer' },
        ['c'] = gen_spec.treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
        },
        -- ['c'] = gen_spec.treesitter({
        --     a = '@conditional.outer',
        --     i = '@conditional.inner',
        -- }),
        ['f'] = gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- Main textobject prefixes
        around = 'a',
        inside = 't',

        -- Next/last variants
        around_next = 'an',
        inside_next = 'tn',
        around_last = 'al',
        inside_last = 'tl',

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = 'gn',
        goto_right = 'gi',
    },

    -- Number of lines within which textobject is searched
    n_lines = 50,

    -- How to search for object (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
    search_method = 'cover',
}
