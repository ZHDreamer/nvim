require("various-textobjs").setup({
    lookForwardSmall = 5,
    lookForwardBig = 15,
    useDefaultKeymaps = false,
})

vim.keymap.set({ "o", "x" }, "as", "<cmd>lua require('various-textobjs').subword(false)<cr>")
vim.keymap.set({ "o", "x" }, "ts", "<cmd>lua require('various-textobjs').subword(true)<cr>")
