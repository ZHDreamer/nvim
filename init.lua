if (vim.g.vscode) then
    require('basic.vscode')
else
    require("basic.keybindings")
end
require("basic.options")
require("basic.plugins")