local gitignore = require("gitignore")
vim.keymap.set("n", "<leader>gi", gitignore.generate, { desc = "Generate [G]it [I]gnore " })
