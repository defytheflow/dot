require("which-key").setup()

vim.keymap.set("n", "<leader>", function() vim.cmd.WhichKey("<leader>") end)
