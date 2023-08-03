vim.keymap.set("n", "<leader>n", require("harpoon.ui").nav_next, { desc = 'Harpoon Next' })
vim.keymap.set("n", "<leader>b", require("harpoon.ui").nav_prev, { desc = 'Harpoon Prev' })
vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, { desc = 'Harpoon Mark' })
vim.keymap.set("n", "<leader>v", require("harpoon.ui").toggle_quick_menu, { desc = 'Harpoon Menu' })
--buffer_manager
