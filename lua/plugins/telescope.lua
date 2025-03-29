return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
            },
        })

        -- Load extensions
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- Key mappings
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fc', builtin.resume, { desc = '[F]ind [C]ontinue' })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ F] Find existing buffers' })
        vim.keymap.set('n', '<leader>fth', builtin.colorscheme, { desc = '[F]ind [Th]eme' })

        -- Fuzzy find in current buffer
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = '[/] Fuzzily find in current buffer' })

        -- Live grep in open files
        vim.keymap.set('n', '<leader>f/', function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            })
        end, { desc = '[F]ind [/] in Open Files' })

        -- Find Neovim configuration files
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, { desc = '[F]ind [N]eovim files' })
    end
}

