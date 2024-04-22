local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Git related plugins
    -- {
    --     'EdenEast/nightfox.nvim',
    --     lazy = false,
    --     config = function()
    --         vim.cmd([[colorscheme nightfox]])
    --         -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --         -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --     end,
    --     priority = 10000,
    -- },
    'tpope/vim-fugitive',
    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth' },
    'tpope/vim-rhubarb',
    { 'themaxmarchuk/tailwindcss-colors.nvim', priority = 5 },
    { 'ThePrimeagen/vim-be-good', priority = -1 },
    {
        'wintermute-cell/gitignore.nvim',
        priority = 10,
        config = function()
            require('/plugin_config/gitignore')
        end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- or
    {
        'nvim-tree/nvim-tree.lua',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('/plugin_config/nvim_tree')
        end,
    },
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'onsails/lspkind.nvim' },
            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim' },

            -- 'folke/neodev.nvim',
        },
    },
    { 'onsails/lspkind.nvim' },
    { -- Autoformat
        'stevearc/conform.nvim',
        opts = {
            notify_on_error = true,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                python = { 'black', 'isort' },
                --
                -- You can use a sub-list to tell conform to run *until* a formatter
                -- is found.
                javascript = { { 'prettierd', 'prettier', 'biome' } },
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        config = function()
            -- Better Around/Inside textobjects
            require('mini.ai').setup({ n_lines = 500 })

            require('mini.surround').setup()

            --     -- Simple and easy statusline.
            --     --  You could remove this setup call if you don't like it,
            --     --  and try some other statusline plugin
            --     local statusline = require('mini.statusline')
            --     -- set use_icons to true if you have a Nerd Font
            --     statusline.setup({ use_icons = vim.g.have_nerd_font })
            --
            --     -- You can configure sections in the statusline by overriding their
            --     -- default behavior. For example, here we set the section for
            --     -- cursor location to LINE:COLUMN
            --     ---@diagnostic disable-next-line: duplicate-set-field
            --     statusline.section_location = function()
            --         return '%2l:%-2v'
            --     end
            --
            --     -- ... and there is more!
            --     --  Check out: https://github.com/echasnovski/mini.nvim
            -- end,
        end,
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        config = function(_, opts)
            -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup(opts)

            -- There are additional nvim-treesitter modules that you can use to interact
            -- with nvim-treesitter. You should go explore a few and see what interests you:
            --
            --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
            --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
            --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        end,
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
                        return
                    end
                    return 'make install_jsregexp'

                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert({
                    -- Select the [n]ext item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete({}),

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
            })
        end,
    },
    { 'windwp/nvim-ts-autotag', priority = 5 },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        priority = 5,
        config = function()
            vim.keymap.set('n', '<leader>et', function()
                require('trouble').toggle()
            end, { desc = 'Toggle Diagnostics' })
            vim.keymap.set('n', '<leader>en', function()
                require('trouble').next({ skip_groups = true, jump = true })
            end, { desc = 'Diagnostcs Next' })
            -- jump to the previous item, skipping the groups
            vim.keymap.set('n', '<leader>eb', function()
                require('trouble').previous({ skip_groups = true, jump = true })
            end, { desc = ' Diagnostics Back' })
        end,
    },
    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {}, lazy = false },
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '' },
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    'n',
                    '[c',
                    require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = 'Go to Previous Hunk' }
                )
                vim.keymap.set(
                    'n',
                    ']c',
                    require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = 'Go to Next Hunk' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>ph',
                    require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' }
                )
            end,
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('/plugin_config/colorizer')
        end,
    },
     { "ellisonleao/gruvbox.nvim",      
        priority = 1000 ,   
        lazy = false,
        config = function()
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox]]) 
            --  vim.cmd([[colorscheme gruvbox]])
             -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
             -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
         end,
         priority = 10000,
 },
    --
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'gruvbox_dark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        config = function()
            require('/plugin_config/rainbow_delimiters')
        end,
        priority = 1,
    },
    { 'numToStr/Comment.nvim', opts = {} },
    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
    },
    -- { 'nvimtools/none-ls.nvim' }, --config = --[[ function() require("/plugin_config/none_ls") end ]] },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
        },
        build = ':TSUpdate',
        config = function()
            require('/plugin_config/tree_sitter')
        end,
    },

    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('/plugin_config/harpoon')
        end,
    },
    -- require('kickstart.plugins.autoformat'),
    -- require 'kickstart.plugins.debug',
    {
        'mbbill/undotree',
        config = function()
            require('/plugin_config/undo_tree')
        end,
    },
    {
        'aznhe21/actions-preview.nvim',
        config = function()
            vim.keymap.set(
                'n',
                'cp',
                require('actions-preview').code_actions,
                { desc = 'Code Telescope' }
            )
        end,
    },
}, {})
