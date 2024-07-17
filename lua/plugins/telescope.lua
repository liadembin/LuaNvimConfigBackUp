return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.6',
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
        })

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        
        -- See `:help telescope.builtin`
        vim.keymap.set(
            'n',
            '<leader>f?',
            require('telescope.builtin').oldfiles,
            { desc = '[?] Find recently opened files' }
        )
        vim.keymap.set(
            'n',
            '<leader>fb',
            require('telescope.builtin').buffers,
            { desc = '[F]ind [B]uffers' }
        )

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fc', builtin.resume, { desc = '[F]ind [C]ontinue' })
        vim.keymap.set(
            'n',
            '<leader>fo',
            builtin.oldfiles,
            { desc = '[F]ind Recent Files ("." for repeat)' }
        )
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ F] Find existing buffers' })
        vim.keymap.set('n', '<leader>fth', builtin.colorscheme, { desc = '[F]ind [Th]eme' })
        
        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = '[/] Fuzzily find in current buffer' })

        -- It's also possible to pass additional configuration options.
        -- See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>f/', function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            })
        end, { desc = '[F]ind [/] in Open Files' })

        -- Shortcut for finding your Neovim configuration files
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, { desc = '[F]ind [N]eovim files' })
    end
}

