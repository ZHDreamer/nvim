local conditions = require("heirline.conditions")
local icons = require("icons")
local utils = require("heirline.utils")

local function setup_colors()
    local mocha = require("catppuccin.palettes").get_palette("mocha")
    return {
        bg = utils.get_highlight("StatusLine").bg,
        fg = utils.get_highlight("StatusLine").fg,
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = mocha["red"],
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_branch = utils.get_highlight("gitBranch").fg,
        git_del = utils.get_highlight("diffRemoved").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
    }
end

local Align = { provider = "%=" }
local Space = { provider = " " }

-- local Icon = {
--     {
--         provider = '  ',
--         hl = function(self)
--             local color = self:mode_color()
--             return { fg = 'bg', bg = color }
--         end,
--     },
--     {
--         provider = '',
--         hl = function(self)
--             local color = self:mode_color()
--             return { fg = color, bg = 'bg' }
--         end,
--     },
--     update = {
--         'ModeChanged',
--     },
-- }

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = {
        mode_names = {
            n = "N",
            no = "N",
            nov = "N",
            noV = "N",
            ["no\22"] = "N",
            niI = "N",
            niR = "N",
            niV = "N",
            nt = "N",
            v = "V",
            vs = "V",
            V = "V",
            Vs = "V",
            ["\22"] = "V",
            ["\22s"] = "V",
            s = "S",
            S = "S",
            ["\19"] = "S",
            i = "I",
            ic = "I",
            ix = "I",
            R = "R",
            Rc = "R",
            Rx = "R",
            Rv = "R",
            Rvc = "R",
            Rvx = "R",
            c = "C",
            cv = "E",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_colors = {
            n = "purple",
            i = "green",
            v = "cyan",
            V = "cyan",
            ["\22"] = "cyan",
            c = "red",
            s = "purple",
            S = "purple",
            ["\19"] = "purple",
            R = "orange",
            r = "orange",
            ["!"] = "red",
            t = "green",
        },
    },
    provider = function(self)
        return "█%2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.mode_colors[mode], bg = "bg", bold = true }
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local FileName = {
    init = function(self)
        self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
        if self.lfilename == "" then
            self.lfilename = "[No Name]"
        end
    end,
    hl = { fg = utils.get_highlight("Directory").fg },

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
        provider = "*",
        hl = { fg = "orange" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
    },
}

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == "help"
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = { bg = "bg" },
    FileIcon,
    FileName,
    FileFlags,
    { provider = "%<" },
}

local Git = {
    condition = conditions.is_git_repo,
    static = {
        branch_icon = icons.GitBranch,
        add_icon = icons.GitAdd,
        change_icon = icons.GitChange,
        delete_icon = icons.GitDelete,
    },

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
        provider = function(self)
            return self.branch_icon .. " " .. self.status_dict.head
        end,
        hl = { fg = "git_branch", bold = false },
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return " " .. self.add_icon .. " " .. count
        end,
        hl = { fg = "git_add" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return " " .. self.change_icon .. " " .. count
        end,
        hl = { fg = "git_change" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return " " .. self.delete_icon .. " " .. count
        end,
        hl = { fg = "git_del" },
    },
    hl = { bg = "bg" },
}

local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%3L%):%2c %P",
}

local ScrollBar = {
    static = {
        -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
        sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i
        if lines > 0 then
            i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        else
            i = #self.sbar
        end
        return string.rep(self.sbar[i], 2)
    end,
    hl = function()
        return { fg = "blue", bg = "bright_bg" }
    end,
}

local LSPActive = {
    condition = conditions.lsp_attached,
    static = {
        lsp_icon = icons.ActiveLSP,
    },
    update = "User LspRequest",

    provider = function(self)
        local names = {}
        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            if server.name ~= "copilot" then
                table.insert(names, server.name)
            end
        end
        return self.lsp_icon .. " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = "green", bg = "bg", bold = true },
    on_click = {
        callback = function()
            vim.defer_fn(function()
                vim.cmd("LspInfo")
            end, 100)
        end,
        name = "heirline_LSP",
    },
}

local Copilot = {
    static = {
        normal_icon = icons.Copilot .. " ",
        loading_icon = icons.CopilotLoading .. " ",
        warning_icon = icons.CopilotWarning .. " ",
        offline_icon = icons.CopilotOffline .. " ",
    },
    init = function(self)
        local api = require("copilot.api")
        api.register_status_notification_handler(function(data)
            -- rewrite the code below
            if data.status == "Normal" then
                self.status = self.normal_icon
                self.fg = "orange"
            elseif data.status == "InProgress" then
                self.status = self.loading_icon
                self.fg = "orange"
            elseif data.status == "Warning" then
                self.status = self.warning_icon
                self.fg = "yellow"
            else
                self.status = self.offline_icon
                self.fg = "red"
            end
        end)
    end,
    provider = function(self)
        return self.status
    end,
    hl = function(self)
        return { fg = self.fg, bg = "bg" }
    end,
}

local Diagnostics = {
    condition = conditions.lsp_attached,
    static = {
        error_icon = icons.DiagnosticError,
        warn_icon = icons.DiagnosticWarn,
        info_icon = icons.DiagnosticInfo,
        hint_icon = icons.DiagnosticHint,
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.error_icon .. " " .. self.errors .. " "
        end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self)
            return self.warn_icon .. " " .. self.warnings .. " "
        end,
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self)
            return self.info_icon .. " " .. self.info .. " "
        end,
        hl = { fg = "diag_info" },
    },
    {
        provider = function(self)
            return self.hint_icon .. " " .. self.hints
        end,
        hl = { fg = "diag_hint" },
    },

    hl = { bg = "bg" },
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
        -- Icon,
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
        Copilot,
        Space,
        Ruler,
        Space,
        ScrollBar,
    },
}

local SpecialStatusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,
    -- Icon,
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
            n = "purple",
            i = "green",
            v = "cyan",
            V = "cyan",
            ["\22"] = "cyan",
            c = "red",
            s = "purple",
            S = "purple",
            ["\19"] = "purple",
            R = "orange",
            r = "orange",
            ["!"] = "red",
            t = "green",
        },
        mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or "n"
            return self.mode_colors_map[mode]
        end,
    },
    SpecialStatusline,
    DefaultStatusline,
}

require("heirline").setup({
    statusline = StatusLines,
})

require("heirline").load_colors(setup_colors())

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        local colors = setup_colors()
        utils.on_colorscheme(colors)
    end,
    group = "Heirline",
})
