local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print('Installing packer close and reopen Neovim...')
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'single' }
        end,
    },
}

return require('packer').startup(function(use)
    --  ██████╗ ██████╗ ██████╗ ███████╗
    -- ██╔════╝██╔═══██╗██╔══██╗██╔════╝
    -- ██║     ██║   ██║██████╔╝█████╗
    -- ██║     ██║   ██║██╔══██╗██╔══╝
    -- ╚██████╗╚██████╔╝██║  ██║███████╗
    --  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    -- Plugin manager
    use('wbthomason/packer.nvim')

    -- Language support manager
    use {
        'williamboman/mason.nvim',
        cond = 'not vim.g.vscode',
        after = { 'nvim-notify' },
        setup = function()
            vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>')
        end,
        config = function()
            require('core.mason')
        end,
    }

    -- Mason support for neovim lsp
    use {
        'williamboman/mason-lspconfig.nvim',
        cond = 'not vim.g.vscode',
        after = { 'mason.nvim' },
        config = function()
            require('mason-lspconfig').setup {
                automatic_installation = true,
            }
        end,
    }

    -- Neovim native lsp
    use {
        'neovim/nvim-lspconfig',
        cond = 'not vim.g.vscode',
        after = { 'mason-lspconfig.nvim' },
        config = function()
            require('core.lspconfig')
        end,
    }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        cond = 'not vim.g.vscode',
        config = function()
            require('core.null-ls')
        end,
    }

    -- ██████╗  █████╗ ███████╗██╗ ██████╗
    -- ██╔══██╗██╔══██╗██╔════╝██║██╔════╝
    -- ██████╔╝███████║███████╗██║██║
    -- ██╔══██╗██╔══██║╚════██║██║██║
    -- ██████╔╝██║  ██║███████║██║╚██████╗
    -- ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝

    -- Persist buffer
    use {
        'olimorris/persisted.nvim',
        cond = 'not vim.g.vscode',
        config = function()
            require('basic.persisted')
        end,
    }

    -- save last cursor position
    -- use {
    --     'ethanholz/nvim-lastplace',
    --     config = function()
    --         require('plugins.nvim-lastplace')
    --     end
    -- }

    -- save last session
    -- use {
    --     'rmagatti/auto-session',
    --     config = function()
    --         require('plugins.auto-session')
    --     end
    -- }

    -- use {
    --     'ZHDreamer/markdown-syntax',
    --     config = function()
    --         vim.cmd([[
    --             let g:markdown_fenced_languages = ['c','cpp','python','java','lua']
    --             let g:markdown_minlines = 100
    --             let g:markdown_fenced_tex = 1
    --         ]])
    --     end
    -- }

    use {
        'nvim-lua/plenary.nvim',
        module = 'plenary',
    }

    use {
        'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons',
    }

    -- ███████╗██████╗ ██╗████████╗██╗███╗   ██╗ ██████╗
    -- ██╔════╝██╔══██╗██║╚══██╔══╝██║████╗  ██║██╔════╝
    -- █████╗  ██║  ██║██║   ██║   ██║██╔██╗ ██║██║  ███╗
    -- ██╔══╝  ██║  ██║██║   ██║   ██║██║╚██╗██║██║   ██║
    -- ███████╗██████╔╝██║   ██║   ██║██║ ╚████║╚██████╔╝
    -- ╚══════╝╚═════╝ ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝

    -- Autopairs
    -- use {
    --     'windwp/nvim-autopairs',
    --     cond = 'not vim.g.vscode',
    --     event = { 'InsertEnter' },
    --     config = function()
    --         require('editing.nvim-autopairs')
    --     end,
    -- }

    -- Switch words
    use {
        'AndrewRadev/switch.vim',
        events = { 'BufferEnter' },
        setup = function()
            vim.keymap.set('n', 'F', '<cmd>Switch<cr>')
        end,
        config = function()
            require('editing.switch')
        end,
    }

    -- comment
    use {
        'numToStr/Comment.nvim',
        cond = 'not vim.g.vscode',
        events = { 'BufferEnter' },
        config = function()
            require('editing.nvim-comment')
        end,
    }

    -- surround
    -- use {
    --     'tpope/vim-surround',
    --     events = { 'BufRead', 'BufNewFile' },
    -- }
    -- use {
    --     'ur4ltz/surround.nvim',
    --     config = function()
    --         require'surround'.setup {
    --             mappings_style = 'surround'
    --         }
    --     end
    -- }

    -- Text objects
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = { 'nvim-treesitter' },
    }
    use {
        'echasnovski/mini.ai',
        after = { 'nvim-treesitter' },
        config = function()
            require('editing.mini-ai')
        end,
    }

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
    use {
        'ggandor/leap.nvim',
        require = {
            'tpope/vim-repeat',
        },
        config = function()
            require('editing.leap')
        end,
    }
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
    use {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set({ 'n', 'v' }, 'ga', '<Plug>(EasyAlign)')
        end,
    }

    -- Markdown PicGo
    use {
        'askfiy/nvim-picgo',
        cond = 'not vim.g.vscode',
        ft = { 'markdown' },
        config = function()
            -- it doesn't require you to do any configuration
            require('nvim-picgo').setup()
        end,
    }

    -- Markdown Preview
    use {
        'iamcco/markdown-preview.nvim',
        cond = 'not vim.g.vscode',
        ft = { 'markdown' },
        run = function()
            vim.fn['mkdp#util#install']()
        end,
    }

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
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('appearance.catppuccin')
            vim.cmd([[
                colorscheme catppuccin
                Catppuccin mocha
            ]])
        end,
    }

    use {
        'connorholyday/vim-snazzy',
    }

    -- Notification
    use {
        'rcarriga/nvim-notify',
        cond = 'not vim.g.vscode',
        config = function()
            require('appearance.nvim-notify')
        end,
    }

    -- Status line
    use {
        'windwp/windline.nvim',
        cond = 'not vim.g.vscode',
        disable = true,
        config = function()
            require('appearance.windline')
        end,
    }
    use {
        'rebelot/heirline.nvim',
        cond = 'not vim.g.vscode',
        disable = false,
        after = { 'catppuccin', 'nvim-lspconfig' },
        config = function()
            require('appearance.heirline')
        end,
    }

    -- Bufferline
    use {
        'akinsho/bufferline.nvim',
        cond = 'not vim.g.vscode',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        after = { 'catppuccin' },
        config = function()
            require('appearance.bufferline')
        end,
    }

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        cond = 'not vim.g.vscode',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        setup = function()
            vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
        end,
        config = function()
            require('appearance.nvim-tree')
        end,
    }

    -- Which key
    use {
        'folke/which-key.nvim',
        cond = 'not vim.g.vscode',
        events = { 'BufRead', 'BufNewFile' },
        config = function()
            require('appearance.which-key')
        end,
    }

    -- gitsigns
    use {

        'lewis6991/gitsigns.nvim',
        cond = 'not vim.g.vscode',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        events = { 'BufRead', 'BufNewFile' },
        config = function()
            require('gitsigns').setup()
        end,
    }

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
    use {
        'nvim-telescope/telescope.nvim',
        cond = 'not vim.g.vscode',
        requires = {
            'nvim-lua/plenary.nvim', -- Lua 开发模块
            'BurntSushi/ripgrep', -- 文字查找
            'sharkdp/fd', -- 文件查找
        },
        module = { 'telescope' },
        cmd = { 'Telescope' },
        setup = function()
            vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
            vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
            vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
            vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
            vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>')
            vim.keymap.set('n', '<leader>fm', '<cmd>Telescope marks<cr>')
            vim.keymap.set('n', '<leader>fn', '<cmd>Telescope notify<cr>')
        end,
        config = function()
            require('utils.telescope')
        end,
    }

    -- IEM support
    use {
        'brglng/vim-im-select',
        config = function()
            vim.cmd([[
                let g:im_select_get_im_cmd = ['im-select']
                if has('win64')
                    let g:im_select_default = '1033'
                endif
            ]])
        end,
    }

    -- ██╗  ██╗██╗ ██████╗ ██╗  ██╗██╗     ██╗ ██████╗ ██╗  ██╗████████╗
    -- ██║  ██║██║██╔════╝ ██║  ██║██║     ██║██╔════╝ ██║  ██║╚══██╔══╝
    -- ███████║██║██║  ███╗███████║██║     ██║██║  ███╗███████║   ██║
    -- ██╔══██║██║██║   ██║██╔══██║██║     ██║██║   ██║██╔══██║   ██║
    -- ██║  ██║██║╚██████╔╝██║  ██║███████╗██║╚██████╔╝██║  ██║   ██║
    -- ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝

    -- Color highlighter for hexrgb and termcolor
    use {
        'norcalli/nvim-colorizer.lua',
        cond = 'not vim.g.vscode',
        events = { 'BufEnter' },
        config = function()
            require('highlight.nvim-colorizer')
        end,
    }

    -- Brackets highlighter
    use {
        'luochen1990/rainbow',
        cond = 'not vim.g.vscode',
        events = { 'BufEnter' },
        config = function()
            require('highlight.rainbow')
        end,
    }

    -- Indent line
    use {
        'lukas-reineke/indent-blankline.nvim',
        cond = 'not vim.g.vscode',
        events = { 'BufEnter' },
        config = function()
            require('highlight.indent-blankline')
        end,
    }

    -- Syntax highlighter
    use {
        'nvim-treesitter/nvim-treesitter',
        -- cond = 'not vim.g.vscode',
        run = ':TSUpdate',
        events = { 'BufEnter' },
        config = function()
            require('highlight.nvim-treesitter')
        end,
    }

    -- Argument highlighter
    use {
        'm-demare/hlargs.nvim',
        disable = true,
        cond = 'not vim.g.vscode',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        events = { 'BufEnter' },
        config = function()
            require('highlight.hlargs')
        end,
    }

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

    use {
        'j-hui/fidget.nvim',
        cond = 'not vim.g.vscode',
        after = { 'nvim-lspconfig' },
        config = function()
            require('fidget').setup {}
        end,
    }

    use {
        'preservim/vim-markdown',
        cond = 'not vim.g.vscode',
        config = function() end,
    }

    --  ██████╗███╗   ███╗██████╗
    -- ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ██╔████╔██║██████╔╝
    -- ██║     ██║╚██╔╝██║██╔═══╝
    -- ╚██████╗██║ ╚═╝ ██║██║
    --  ╚═════╝╚═╝     ╚═╝╚═╝
    -- use {
    --     'hrsh7th/nvim-cmp', -- 代码补全核心插件，下面都是增强补全的体验插件
    --     disable = false,
    --     events = { 'InsertEnter' },
    --     requires = {
    --         { 'onsails/lspkind-nvim' }, -- 为补全添加类似 vscode 的图标
    --         { 'hrsh7th/vim-vsnip' }, -- vsnip 引擎，用于获得代码片段支持
    --         { 'hrsh7th/cmp-vsnip' }, -- 适用于 vsnip 的代码片段源
    --         { 'hrsh7th/cmp-nvim-lsp' }, -- 替换内置 omnifunc，获得更多补全
    --         { 'hrsh7th/cmp-path' }, -- 路径补全
    --         { 'hrsh7th/cmp-buffer' }, -- 缓冲区补全
    --         { 'hrsh7th/cmp-cmdline' }, -- 命令补全
    --         { 'f3fora/cmp-spell' }, -- 拼写建议
    --         { 'rafamadriz/friendly-snippets' }, -- 提供多种语言的代码片段
    --         { 'lukas-reineke/cmp-under-comparator' }, -- 让补全结果的排序更加智能
    --         { 'kdheepak/cmp-latex-symbols' },
    --         -- {'tzachar/cmp-tabnine', run = './install.sh'} -- tabnine 源,提供基于 AI 的智能补全
    --     },
    --     config = function()
    --         require('cmp.nvim-cmp')
    --     end,
    -- }

    -- use {
    --     'sbdchd/neoformat',
    --     events = { 'BufWrite' },
    --     config = function()
    --         require('lsp.formatter')
    --     end,
    -- }
end)
