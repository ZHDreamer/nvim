require('nvim-autopairs').setup(
    {
    -- Before        Input         After
    -- ------------------------------------
    -- (  |))         (            (  (|))
    enable_check_bracket_line = true,

    -- Before        Input         After
    -- ------------------------------------
    -- |foobar        (            (|foobar
    -- |.foobar       (            (|.foobar
    ignored_next_char = '[%w%.]', -- will ignore alphanumeric and `.` symbol
    map_cr = true
    }
)

local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'

--[[
| Before  | Insert  | After   |
| :-----  | :-----  | :------ |
| `(|)`   | `space` | `( | )` |
| `( | )` | `)`     | `( )|`  |
--]]
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
