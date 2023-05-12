local actions = require("telescope.actions")
local telescope = require("telescope")
local cutoff = 120

telescope.setup({
    defaults = {
        layout_strategy = "flex",
        layout_config = {
            flex = {
                flip_columns = cutoff,
                vertical = {
                    preview_cutoff = cutoff,
                },
            },
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-u>"] = actions.move_selection_previous,
                ["<C-e>"] = actions.move_selection_next,
            },
            n = {
                ["u"] = actions.move_selection_previous,
                ["e"] = actions.move_selection_next,
            },
        },
    },
})

telescope.load_extension("notify")
