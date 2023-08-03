require("refactoring").setup({})
local refactor_modes = { "x", "v", "n" }
vim.keymap.set(refactor_modes, "<leader>re", ":Refactor extract", { desc = ":Refactor extract " })
vim.keymap.set(refactor_modes, "<leader>rf", ":Refacor extract_to_file", { desc = ":Refactor extract_to_file " })
vim.keymap.set(refactor_modes, "<leader>rv", ":Refactor extract_var", { desc = ":Refactor extract_var " })
vim.keymap.set(refactor_modes, "<leader>ri", ":Refactor inline_var", { desc = ":Refactor inline_var" })
vim.keymap.set(refactor_modes, "<leader>rb", ":Refactor extract_block", { desc = ":Refactor extract_block" })
vim.keymap.set(refactor_modes, "<leader>rbf", ":Refactor extract_block_to_file",
  { desc = ":Refactor extract_block_to_file" })
