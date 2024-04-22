vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require('nvim-tree').setup({
    sort_by = 'case_sensitive',
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
})
vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>')
