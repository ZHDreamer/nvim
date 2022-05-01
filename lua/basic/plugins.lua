---@diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
    -- 包管理器
    use 'wbthomason/packer.nvim'

    -- nvim-tree
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            -- 依赖一个图标插件
            "kyazdani42/nvim-web-devicons"
        },
        config = function()
            require("plugins.nvim-tree")
        end
    }

    -- feline
    use {
        'feline-nvim/feline.nvim',
        require('feline').setup()
    }
end)

