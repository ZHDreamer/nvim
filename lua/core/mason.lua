-- https://github.com/williamboman/mason.nvim

require('mason').setup({
    ui = {
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = 'single',

        icons = {
            -- The list icon to use for installed packages.
            package_installed = '✓',
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = '➜',
            -- The list icon to use for packages that are not installed.
            package_uninstalled = '✗'
        },

        keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = '<CR>',
            -- Keymap to install the package under the current cursor position
            install_package = 'a',
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = 's',
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = 'c',
            -- Keymap to update all installed packages
            update_all_packages = 'S',
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = 'C',
            -- Keymap to uninstall a package
            uninstall_package = 'X',
            -- Keymap to cancel a package installation
            cancel_installation = '<C-c>',
            -- Keymap to apply language filter
            apply_language_filter = '<C-f>',
        },
    },

    pip = {
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        -- Example: { '--proxy', 'https://proxyserver' }
        install_args = {},
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    github = {
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. 'rust-lang/rust-analyzer')
        -- 2. The release version (e.g. 'v0.3.0')
        -- 3. The asset name (e.g. 'rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz')
        download_url_template = 'https://github.com/%s/releases/download/%s/%s',
    },
})

local resources = {
    lsp = {
        'clangd',
        'pyright',
        'vim-language-server',
        'lua-language-server',
        'bash-language-server',
    },
    -- dap = {
    --     'delve',
    --     'debugpy',
    -- },
    -- linter = {
    --     'pylint',
    -- },
    formatter = {
        'clang-format',
        'black',
    },
}
local installed_resources = {}
local mason_registry = require('mason-registry')

for _, resource_tbl in pairs(resources) do
    for _, resource_name in pairs(resource_tbl) do
        if not mason_registry.is_installed(resource_name) then
            local ok, resource = pcall(mason_registry.get_package, resource_name)
            if ok then
                resource:install()
                table.insert(installed_resources, resource_name)
            else
                vim.notify(string.format('Invalid resource name %s', resource_name), 'ERROR', { title = 'Mason' })
            end
        end
    end
end

if not vim.tbl_isempty(installed_resources) then
    vim.notify(
        string.format('Install resource: \n - %s', table.concat(installed_resources, '\n - ')),
        'INFO',
        { title = 'Mason' }
    )
end
