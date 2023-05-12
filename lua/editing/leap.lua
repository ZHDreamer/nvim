local leap = require("leap")

leap.opts.max_phase_one_targets = nil
leap.opts.highlight_unlabeled_phase_one_targets = false
leap.opts.max_highlighted_traversal_targets = 10
leap.opts.case_sensitive = false
leap.opts.equivalence_classes = { " \t\r\n", "\"'`" }
leap.opts.substitute_chars = {}
leap.opts.safe_labels = {}
leap.opts.labels = {
    "n",
    "e",
    "i",
    "o",
    "t",
    "s",
    "r",
    "a",
    "h",
    "u",
    "y",
    "f",
    "w",
    "h",
    "m",
    "/",
    "d",
    "v",
    "c",
    "x",
    "z",
    "k",
    "j",
    "b",
    "g",
    "q",
}
leap.opts.special_keys = {
    repeat_search = "<enter>",
    next_phase_one_target = "<enter>",
    next_target = { "<enter>", ";" },
    prev_target = { "<tab>", "," },
    next_group = "<space>",
    prev_group = "<tab>",
    multi_accept = "<enter>",
    multi_revert = "<backspace>",
}
vim.keymap.set("", "<C-y>", "<Plug>(leap-forward-to)")
vim.keymap.set("", "<C-l>", "<Plug>(leap-backward-to)")
-- vim.keymap.set('', 'gs', '<Plug>(leap-cross-window)')
