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

        -- surround

        use 'tpope/vim-surround'
    --     use {
    --         'ur4ltz/surround.nvim',
    --         config = function()
    --             require'surround'.setup {
    --                 mappings_style = 'surround'
    --             }
    --         end
    --     }
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
    end)
else
    return require('packer').startup(function()
        use 'wbthomason/packer.nvim'

        use 'tpope/vim-surround'
    end)
end

