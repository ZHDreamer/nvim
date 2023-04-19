-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

lazy.setup {
    --  ██████╗ ██████╗ ██████╗ ███████╗
    -- ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    -- ██║     ██║   ██║██████╔╝█████╗
    -- ██║     ██║   ██║██╔══██╗██╔══╝
    -- ╚██████╗╚██████╔╝██║  ██║███████╗
    --  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
    'folke/neodev.nvim',

    -- Language support manager
    {
        'williamboman/mason.nvim',
        dependencies = { 'nvim-notify' },
        cond = not vim.g.vscode,
        lazy = true,
        cmd = { 'Mason' },
        init = function()
            vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>')
        end,
        config = function()
            require('core.mason')
        end,
    },
    -- Mason support for neovim lsp
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'mason.nvim' },
        cond = not vim.g.vscode,
        config = function()
            require('mason-lspconfig').setup {
                automatic_installation = true,
            }
        end,
    },
    -- Neovim native lsp
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        cond = not vim.g.vscode,
        config = function()
            require('core.lspconfig')
        end,
    },

    {
        'jose-elias-alvarez/null-ls.nvim',
        cond = not vim.g.vscode,
        config = function()
            require('core.null-ls')
        end,
    },

    -- ██████╗  █████╗ ███████╗██╗ ██████╗
    -- ██╔══██╗██╔══██╗██╔════╝██║██╔════╝
    -- ██████╔╝███████║███████╗██║██║
    -- ██╔══██╗██╔══██║╚════██║██║██║
    -- ██████╔╝██║  ██║███████║██║╚██████╗
    -- ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝

    -- Persist buffer
    {
        'olimorris/persisted.nvim',
        cond = not vim.g.vscode,
        config = function()
            require('basic.persisted')
        end,
    },

    'nvim-lua/plenary.nvim',

    'kyazdani42/nvim-web-devicons',

    -- ███████╗██████╗ ██╗████████╗██╗███╗   ██╗ ██████╗
    -- ██╔════╝██╔══██╗██║╚══██╔══╝██║████╗  ██║██╔════╝
    -- █████╗  ██║  ██║██║   ██║   ██║██╔██╗ ██║██║  ███╗
    -- ██╔══╝  ██║  ██║██║   ██║   ██║██║╚██╗██║██║   ██║
    -- ███████╗██████╔╝██║   ██║   ██║██║ ╚████║╚██████╔╝
    -- ╚══════╝╚═════╝ ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝

    -- Switch words
    {
        'AndrewRadev/switch.vim',
        lazy = true,
        cmd = { 'Switch' },
        keys = {
            { 'F', '<cmd>Switch<cr>' },
        },
        config = function()
            require('editing.switch')
        end,
    },

    -- comment
    {
        'numToStr/Comment.nvim',
        cond = not vim.g.vscode,
        config = function()
            require('editing.nvim-comment')
        end,
    },

    -- surround
    {
        'kylechui/nvim-surround',
        config = function()
            require('editing.surround')
        end,
    },

    -- Text objects
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter' },
    },
    {
        'echasnovski/mini.ai',
        dependencies = { 'nvim-treesitter' },
        config = function()
            require('editing.mini-ai')
        end,
    },

    -- Motion
    -- use {
    --     'phaazon/hop.nvim',
    --     setup = function()
    --         -- place this in one of your configuration file(s)
    --         -- vim.keymap.set(
    --         --     '',
    --         --     'f',
    --         --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    --         -- )
    --         -- vim.keymap.set(
    --         --     '',
    --         --     'F',
    --         --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    --         -- )
    --         -- vim.keymap.set(
    --         --     '',
    --         --     't',
    --         --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
    --         -- )
    --         -- vim.keymap.set(
    --         --     '',
    --         --     'T',
    --         --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
    --         -- )
    --         vim.keymap.set('', 'k', '<cmd>HopWord<cr>')
    --         vim.keymap.set('', 'K', '<cmd>HopLineStart<cr>')
    --         vim.keymap.set('', '\\', '<cmd>lua require"hop".hint_patterns({ case_insensitive = false })<cr>')
    --     end,
    --     config = function()
    --         require('editing.hop')
    --     end,
    -- }
    {
        'ggandor/leap.nvim',
        dependencies = {
            'tpope/vim-repeat',
        },
        config = function()
            require('editing.leap')
        end,
    },

    {
        'tpope/vim-repeat',
        enabled = false,
        keys = {
            -- { '.', '<plug>(RepeatDot)', mode = '' },
            -- { 'v', '<plug>(RepeatUndo)', mode = '' },
            -- { 'V', '<plug>(RepeatRedo)', mode = '' },
        },
    },
    -- use {
    --     'ggandor/flit.nvim',
    --     require = {
    --         'ggandor/leap.nvim',
    --     },
    --     config = function()
    --         require('flit').setup {
    --             keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    --             -- A string like "nv", "nvo", "o", etc.
    --             labeled_modes = 'v',
    --             multiline = true,
    --             -- Like `leap`s similar argument (call-specific overrides).
    --             -- E.g.: opts = { equivalence_classes = {} }
    --             opts = {},
    --         }
    --     end,
    -- }

    -- Align
    {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set({ 'n', 'v' }, 'ga', '<Plug>(EasyAlign)')
        end,
    },

    -- Markdown PicGo
    {
        'askfiy/nvim-picgo',
        cond = not vim.g.vscode,
        ft = { 'markdown' },
        config = function()
            -- it doesn't require you to do any configuration
            require('nvim-picgo').setup()
        end,
    },

    -- Markdown Preview
    {
        'iamcco/markdown-preview.nvim',
        cond = not vim.g.vscode,
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },

    -- Markdown

    -- use{
    --     'preservim/vim-markdown',
    --     config = function()
    --         require('plugins.vim-markdown')
    --     end
    -- }

    --  █████╗ ██████╗ ██████╗ ███████╗ █████╗ ██████╗  █████╗ ███╗   ██╗ ██████╗███████╗
    -- ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗████╗  ██║██╔════╝██╔════╝
    -- ███████║██████╔╝██████╔╝█████╗  ███████║██████╔╝███████║██╔██╗ ██║██║     █████╗
    -- ██╔══██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██║██╔══██╗██╔══██║██║╚██╗██║██║     ██╔══╝
    -- ██║  ██║██║     ██║     ███████╗██║  ██║██║  ██║██║  ██║██║ ╚████║╚██████╗███████╗
    -- ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝

    -- Color scheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('appearance.catppuccin')
            vim.cmd([[
                colorscheme catppuccin
                Catppuccin mocha
            ]])
        end,
    },

    {
        'connorholyday/vim-snazzy',
    },

    -- Notification
    {
        'rcarriga/nvim-notify',
        cond = not vim.g.vscode,
        config = function()
            require('appearance.nvim-notify')
        end,
    },

    -- Status line
    {
        'windwp/windline.nvim',
        cond = not vim.g.vscode,
        enabled = false,
        config = function()
            require('appearance.windline')
        end,
    },
    {
        'rebelot/heirline.nvim',
        cond = not vim.g.vscode,
        enabled = true,
        dependencies = { 'catppuccin', 'nvim-lspconfig' },
        config = function()
            require('appearance.heirline')
        end,
    },

    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        cond = not vim.g.vscode,
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        enabled = { 'catppuccin' },
        config = function()
            require('appearance.bufferline')
        end,
    },

    -- File explorer
    {
        'kyazdani42/nvim-tree.lua',
        cond = not vim.g.vscode,
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        lazy = true,
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        keys = {
            { '<leader>e', '<cmd>NvimTreeToggle<cr>' },
        },
        config = function()
            require('appearance.nvim-tree')
        end,
    },

    -- Which key
    {
        'folke/which-key.nvim',
        cond = not vim.g.vscode,
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            require('appearance.which-key')
        end,
    },

    -- gitsigns
    {
        'lewis6991/gitsigns.nvim',
        cond = not vim.g.vscode,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        lazy = true,
        event = { 'BufEnter' },
        config = function()
            require('gitsigns').setup()
        end,
    },

    -- zen-mode
    -- use {
    --     'folke/zen-mode.nvim',
    --     config = function()
    --         require('zen-mode').setup {
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             -- refer to the configuration section below
    --         }
    --     end
    -- }

    -- ██╗   ██╗████████╗██╗██╗     ███████╗
    -- ██║   ██║╚══██╔══╝██║██║     ██╔════╝
    -- ██║   ██║   ██║   ██║██║     ███████╗
    -- ██║   ██║   ██║   ██║██║     ╚════██║
    -- ╚██████╔╝   ██║   ██║███████╗███████║
    --  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝

    -- use {
    --     'nvim-pack/nvim-spectre',
    --     requires = {
    --         'nvim-lua/plenary.nvim', -- Lua 开发模块
    --         'BurntSushi/ripgrep' -- 文字查找
    --     },
    --     config = function()
    --         require('utils.nvim-spectre')
    --     end
    -- }

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        cond = not vim.g.vscode,
        dependencies = {
            'nvim-lua/plenary.nvim', -- Lua 开发模块
            'BurntSushi/ripgrep', -- 文字查找
            'sharkdp/fd', -- 文件查找
        },
        lazy = true,
        cmd = { 'Telescope' },
        keys = {
            { '<leader>sf', '<cmd>Telescope find_files hidden=true<cr>', desc = '[S]earch [F]iles' },
            { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = '[S]earch [B]uffers' },
            { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elps' },
            { '<leader>sm', '<cmd>Telescope marks<cr>', desc = '[S]earch [M]arks' },
            { '<leader>sn', '<cmd>Telescope notify<cr>', desc = '[S]earch [N]otifies' },
        },
        config = function()
            require('utils.telescope')
        end,
    },

    -- IEM support
    {
        'brglng/vim-im-select',
        lazy = true,
        event = { 'InsertEnter' },
        config = function()
            vim.cmd([[
                let g:im_select_get_im_cmd = ['im-select']
                if has('win64')
                    let g:im_select_default = '1033'
                endif
            ]])
        end,
    },

    -- ██╗  ██╗██╗ ██████╗ ██╗  ██╗██╗     ██╗ ██████╗ ██╗  ██╗████████╗
    -- ██║  ██║██║██╔════╝ ██║  ██║██║     ██║██╔════╝ ██║  ██║╚══██╔══╝
    -- ███████║██║██║  ███╗███████║██║     ██║██║  ███╗███████║   ██║
    -- ██╔══██║██║██║   ██║██╔══██║██║     ██║██║   ██║██╔══██║   ██║
    -- ██║  ██║██║╚██████╔╝██║  ██║███████╗██║╚██████╔╝██║  ██║   ██║
    -- ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝

    -- Color highlighter for hexrgb and termcolor
    {
        'norcalli/nvim-colorizer.lua',
        cond = not vim.g.vscode,
        lazy = true,
        event = { 'BufEnter' },
        config = function()
            require('highlight.nvim-colorizer')
        end,
    },

    -- Brackets highlighter
    {
        'luochen1990/rainbow',
        cond = not vim.g.vscode,
        lazy = true,
        event = { 'BufEnter' },
        config = function()
            require('highlight.rainbow')
        end,
    },

    -- Indent line
    {
        'lukas-reineke/indent-blankline.nvim',
        cond = not vim.g.vscode,
        lazy = true,
        event = { 'BufEnter' },
        config = function()
            require('highlight.indent-blankline')
        end,
    },

    -- Syntax highlighter
    {
        'nvim-treesitter/nvim-treesitter',
        -- cond = not vim.g.vscode,
        lazy = true,
        event = { 'BufEnter' },
        build = ':TSUpdate',
        config = function()
            require('highlight.nvim-treesitter')
        end,
    },

    -- Argument highlighter
    {
        'm-demare/hlargs.nvim',
        enabled = false,
        cond = not vim.g.vscode,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = { 'BufEnter' },
        config = function()
            require('highlight.hlargs')
        end,
    },

    -- ██╗     ███████╗██████╗
    -- ██║     ██╔════╝██╔══██╗
    -- ██║     ███████╗██████╔╝
    -- ██║     ╚════██║██╔═══╝
    -- ███████╗███████║██║
    -- ╚══════╝╚══════╝╚═╝

    -- use {
    --     'tami5/lspsaga.nvim',
    --     after = { 'nvim-lspconfig' },
    --     config = function()
    --         require('lsp.lspsaga')
    --     end
    -- }

    {
        'j-hui/fidget.nvim',
        cond = not vim.g.vscode,
        dependencies = { 'nvim-lspconfig' },
        config = function()
            require('fidget').setup {}
        end,
    },

    {
        'preservim/vim-markdown',
        cond = not vim.g.vscode,
        config = function() end,
    },

    --  ██████╗███╗   ███╗██████╗
    -- ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ██╔████╔██║██████╔╝
    -- ██║     ██║╚██╔╝██║██╔═══╝
    -- ╚██████╗██║ ╚═╝ ██║██║
    --  ╚═════╝╚═╝     ╚═╝╚═╝
    {
        'hrsh7th/nvim-cmp', -- 代码补全核心插件，下面都是增强补全的体验插件
        enable = true,
        cond = not vim.g.vscode,
        lazy = true,
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            { 'onsails/lspkind-nvim' }, -- 为补全添加类似 vscode 的图标
            { 'hrsh7th/vim-vsnip' }, -- vsnip 引擎，用于获得代码片段支持
            { 'hrsh7th/cmp-vsnip' }, -- 适用于 vsnip 的代码片段源
            { 'hrsh7th/cmp-nvim-lsp' }, -- 替换内置 omnifunc，获得更多补全
            { 'hrsh7th/cmp-path' }, -- 路径补全
            { 'hrsh7th/cmp-buffer' }, -- 缓冲区补全
            { 'hrsh7th/cmp-cmdline' }, -- 命令补全
            { 'f3fora/cmp-spell' }, -- 拼写建议
            { 'rafamadriz/friendly-snippets' }, -- 提供多种语言的代码片段
            { 'lukas-reineke/cmp-under-comparator' }, -- 让补全结果的排序更加智能
            { 'kdheepak/cmp-latex-symbols' },
            -- {'tzachar/cmp-tabnine', run = './install.sh'} -- tabnine 源,提供基于 AI 的智能补全
        },
        config = function()
            require('cmp.nvim-cmp')
        end,
    },

    -- use {
    --     'sbdchd/neoformat',
    --     event = { 'BufWrite' },
    --     config = function()
    --         require('lsp.formatter')
    --     end,
    -- }
}
