local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
        return require('packer.util').float { border = 'rounded' }
        end,
    },
}

if (not vim.g.vscode) then
    return require('packer').startup(function()
        -- 包管理器
        use 'wbthomason/packer.nvim'

        -- color scheme
        use {
            'catppuccin/nvim',
            as = 'catppuccin',
            config = function()
                require('plugins.catppuccin')
            end
        }
        -- nvim-tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                -- 依赖一个图标插件
                'kyazdani42/nvim-web-devicons'
            },
            config = function()
                require('plugins.nvim-tree')
            end
        }

        -- save last cursor position
        use {
            "ethanholz/nvim-lastplace",
            config = function()
                require('plugins.nvim-lastplace')
            end
        }

        -- save last session
        -- use {
        --     'rmagatti/auto-session',
        --     config = function()
        --         require('plugins.auto-session')
        --     end
        -- }

        -- windline
        use {
            'windwp/windline.nvim',
            config = function()
                require ('plugins.windline')
            end
        }

        -- gitsigns
        use {

            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim'
            },
            config = function()
                require('gitsigns').setup()
            end
        }

        -- bufferline
        use {
            'akinsho/bufferline.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons'
            },
            config = function()
                require('plugins.bufferline')
            end
        }

        -- indent line
        -- use 'lukas-reineke/indent-blankline.nvim'
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('plugins.indent-blankline')
            end
        }

        -- Autopairs
        use {
            'windwp/nvim-autopairs',
            config = function()
                require('plugins.nvim-autopairs')
            end
        }

        -- comment

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('plugins.nvim-comment')
            end
        }
        -- surround

        use 'tpope/vim-surround'
        -- use {
        --     'ur4ltz/surround.nvim',
        --     config = function()
        --         require'surround'.setup {
        --             mappings_style = 'surround'
        --         }
        --     end
        -- }
        use {
            'junegunn/vim-easy-align',
            config = function()
                vim.keymap.set({ 'n', 'v' }, 'ga', '<Plug>(EasyAlign)')
            end
        }

        -- Markdown PicGo
        use {
            "askfiy/nvim-picgo",
            config = function()
                -- it doesn't require you to do any configuration
                require("nvim-picgo").setup()
            end
        }

        -- Markdown Preview
--         use{
--             "iamcco/markdown-preview.nvim",
--             run = function() vim.fn["mkdp#util#install"]() end,
--         }

        use{
            "davidgranstrom/nvim-markdown-preview"
        }
        -- zen-mode
        use {
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
          end
        }

        --  ██████╗███╗   ███╗██████╗
        -- ██╔════╝████╗ ████║██╔══██╗
        -- ██║     ██╔████╔██║██████╔╝
        -- ██║     ██║╚██╔╝██║██╔═══╝
        -- ╚██████╗██║ ╚═╝ ██║██║
        --  ╚═════╝╚═╝     ╚═╝╚═╝
        use {
            "hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
            requires = {
                {"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
                {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
                {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
                {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
                {"hrsh7th/cmp-path"}, -- 路径补全
                {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
                {"hrsh7th/cmp-cmdline"}, -- 命令补全
                {"f3fora/cmp-spell"}, -- 拼写建议
                {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
                {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
                -- {"tzachar/cmp-tabnine", run = "./install.sh"} -- tabnine 源,提供基于 AI 的智能补全
            },
            config = function()
                require('plugins.nvim-cmp')
            end
        }
    end)
else
    return require('packer').startup(function()
        use 'wbthomason/packer.nvim'

        use 'tpope/vim-surround'
    end)
end

