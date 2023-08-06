vim.keymap.set("n", "<leader>mb", require("buffer_manager.ui").nav_prev, { desc = "[B]uffer [B]ack" })
vim.keymap.set("n", "<leader>mm", function() require 'buffer_manager.ui'.save_menu_to_file('bm') end,
  { desc = "[B]uffer Save" })
vim.keymap.set("n", "<leader>bf", function() require 'buffer_manager.ui'.load_menu_from_file('bm') end,
  { desc = "[B]uffer [F]rom [F]ile" })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- Move to previous/next
map('n', '<leader>o[', '<Cmd>BufferPrevious<CR>', { desc = "Previous Buffer" })
map('n', '<leader>o]', '<Cmd>BufferNext<CR>', { desc = "Next Buffer" })

-- Re-order to previous/next
-- map('n', '<leader>om[', '<Cmd>BufferMovePrevious<CR>', opts)
-- map('n', '<leader>om]', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<leader>op', '<Cmd>BufferPin<CR>', { desc = "Pin Buffer" })
-- Close buffer
map('n', '<leader>oc', '<Cmd>BufferClose<CR>', { desc = "Close Buffer" })
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
--map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
