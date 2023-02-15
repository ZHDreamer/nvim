local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local function setup_colors()
    local mocha = require('catppuccin.palettes').get_palette('mocha')
    return {
        bg = utils.get_highlight('StatusLine').bg,
        fg = utils.get_highlight('StatusLine').fg,
        bright_bg = utils.get_highlight('Folded').bg,
        bright_fg = utils.get_highlight('Folded').fg,
        red = mocha['red'],
        dark_red = utils.get_highlight('DiffDelete').bg,
        green = utils.get_highlight('String').fg,
        blue = utils.get_highlight('Function').fg,
        gray = utils.get_highlight('NonText').fg,
        orange = utils.get_highlight('Constant').fg,
        purple = utils.get_highlight('Statement').fg,
        cyan = utils.get_highlight('Special').fg,
        diag_warn = utils.get_highlight('DiagnosticWarn').fg,
        diag_error = utils.get_highlight('DiagnosticError').fg,
        diag_hint = utils.get_highlight('DiagnosticHint').fg,
        diag_info = utils.get_highlight('DiagnosticInfo').fg,
        git_branch = utils.get_highlight('gitBranch').fg,
        git_del = utils.get_highlight('diffRemoved').fg,
        git_add = utils.get_highlight('diffAdded').fg,
        git_change = utils.get_highlight('diffChanged').fg,
    }
end

local Align = { provider = '%=' }
local Space = { provider = ' ' }

local Icon = {
    {
        provider = '  ',
        hl = function(self)
            local color = self:mode_color()
            return { fg = 'bg', bg = color }
        end,
    },
    {
        provider = '',
        hl = function(self)
            local color = self:mode_color()
            return { fg = color, bg = 'bg' }
        end,
    },
    update = {
        'ModeChanged',
    },
}

local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd('ModeChanged', {
                pattern = '*:*',
                command = 'redrawstatus',
            })
            self.once = true
        end
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = 'N',
            no = 'N',
            nov = 'N',
            noV = 'N',
            ['no\22'] = 'N',
            niI = 'N',
            niR = 'N',
            niV = 'N',
            nt = 'N',
            v = 'V',
            vs = 'V',
            V = 'V',
            Vs = 'V',
            ['\22'] = 'V',
            ['\22s'] = 'V',
            s = 'S',
            S = 'S',
            ['\19'] = 'S',
            i = 'I',
            ic = 'I',
            ix = 'I',
            R = 'R',
            Rc = 'R',
            Rx = 'R',
            Rv = 'R',
            Rvc = 'R',
            Rvx = 'R',
            c = 'C',
            cv = 'E',
            r = '...',
            rm = 'M',
            ['r?'] = '?',
            ['!'] = '!',
            t = 'T',
        },
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    {
        provider = function(self)
            return '%2(' .. self.mode_names[self.mode] .. '%) '
        end,
        hl = function(self)
            local color = self:mode_color() -- here!
            return { fg = color, bg = 'bg', bold = true }
        end,
    },
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    -- Re-evaluate the component only on ModeChanged event!
    -- This is not required in any way, but it's there, and it's a small
    -- performance improvement.
    update = {
        'ModeChanged',
    },
}
-- ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color =
            require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}
local FileName = {
    init = function(self)
        self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
        if self.lfilename == '' then
            self.lfilename = '[No Name]'
        end
    end,
    hl = { fg = utils.get_highlight('Directory').fg },

    {
        flexible = 2,
        {
            provider = function(self)
                return self.lfilename
            end,
        },
        {
            provider = function(self)
                return vim.fn.pathshorten(self.lfilename)
            end,
        },
    },
}

local FileFlags = {
    fallthrough = false,
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = '*',
        hl = { fg = 'orange' },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = '',
        hl = { fg = 'orange' },
    },
    {
        provider = ' ',
    },
}

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight('Type').fg, bold = true },
}

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == 'help'
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ':t')
    end,
    hl = { fg = utils.get_highlight('Directory').fg },
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = { bg = 'bg' },
    FileIcon,
    FileName,
    FileFlags,
    { provider = '%<' },
}

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
        provider = function(self)
            return ' ' .. self.status_dict.head
        end,
        hl = { fg = 'git_branch', bold = false },
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return '  ' .. count
        end,
        hl = { fg = 'git_add' },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return '  ' .. count
        end,
        hl = { fg = 'git_change' },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return '  ' .. count
        end,
        hl = { fg = 'git_del' },
    },
    hl = { bg = 'bg' },
}

local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = '%7(%l/%3L%):%2c %P',
}

local ScrollBar = {
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = function()
        return { fg = 'blue', bg = 'bright_bg' }
    end,
}

local LSPActive = {
    condition = conditions.lsp_attached,
    update = 'User LspRequest',

    provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
            table.insert(names, server.name)
        end
        return ' [' .. table.concat(names, ' ') .. ']'
    end,
    hl = { fg = 'green', bg = 'bg', bold = true },
}

local Diagnostics = {
    condition = conditions.lsp_attached,
    static = {
        error_icon = ' ',
        warn_icon = ' ',
        info_icon = ' ',
        hint_icon = ' ',
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { 'DiagnosticChanged', 'BufEnter' },

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.error_icon .. self.errors .. ' '
        end,
        hl = { fg = 'diag_error' },
    },
    {
        provider = function(self)
            return self.warn_icon .. self.warnings .. ' '
        end,
        hl = { fg = 'diag_warn' },
    },
    {
        provider = function(self)
            return self.info_icon .. self.info .. ' '
        end,
        hl = { fg = 'diag_info' },
    },
    {
        provider = function(self)
            return self.hint_icon .. self.hints
        end,
        hl = { fg = 'diag_hint' },
    },

    hl = { bg = 'bg' },
}

local DefaultStatusline = {
    fallthrough = false,
    {
        condition = conditions.is_not_active,
        FileNameBlock,
        Align,
        Align,
        Ruler,
    },
    {
        Icon,
        ViMode,
        Space,
        FileNameBlock,
        Space,
        Git,
        Space,
        Align,
        Align,
        Diagnostics,
        Space,
        LSPActive,
        Space,
        Ruler,
        Space,
        ScrollBar,
    },
}

local SpecialStatusline = {
    condition = function()
        return conditions.buffer_matches {
            buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
            filetype = { '^git.*', 'fugitive' },
        }
    end,
    Icon,
    ViMode,
    Space,
    FileType,
    Space,
    HelpFileName,
    Align,
    Align,
    Ruler,
    Space,
    ScrollBar,
}

local StatusLines = {
    fallthrough = false,

    static = {
        mode_colors_map = {
            n = 'purple',
            i = 'green',
            v = 'cyan',
            V = 'cyan',
            ['\22'] = 'cyan',
            c = 'red',
            s = 'purple',
            S = 'purple',
            ['\19'] = 'purple',
            R = 'orange',
            r = 'orange',
            ['!'] = 'red',
            t = 'green',
        },
        mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or 'n'
            return self.mode_colors_map[mode]
        end,
    },
    SpecialStatusline,
    DefaultStatusline,
}

require('heirline').setup { statusline = StatusLines }

require('heirline').load_colors(setup_colors())

vim.api.nvim_create_augroup('Heirline', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local colors = setup_colors()
        utils.on_colorscheme(colors)
    end,
    group = 'Heirline',
})
