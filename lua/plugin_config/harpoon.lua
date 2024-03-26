local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>n", require("harpoon.ui").nav_next, { desc = 'Harpoon Next' })
vim.keymap.set("n", "<leader>b", require("harpoon.ui").nav_prev, { desc = 'Harpoon Prev' })
vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, { desc = 'Harpoon Mark' })
vim.keymap.set("n", "<leader>v", require("harpoon.ui").toggle_quick_menu, { desc = 'Harpoon Menu' })
vim.keymap.set("n", "g1", function() require("harpoon.ui").nav_file(1) end, { desc = "[G]oto [1]" })
vim.keymap.set("n", "g2", function() require("harpoon.ui").nav_file(2) end, { desc = "[G]oto [2]" })
vim.keymap.set("n", "g3", function() require("harpoon.ui").nav_file(3) end, { desc = "[G]oto [3]" })
vim.keymap.set("n", "g4", function() require("harpoon.ui").nav_file(4) end, { desc = "[G]oto [4]" })
vim.keymap.set("n", "g5", function() require("harpoon.ui").nav_file(5) end, { desc = "[G]oto [5]" })
--buffer_manager
--Error detected while processing C:\Users\liad8\AppData\Local\nvim\init.lua:
