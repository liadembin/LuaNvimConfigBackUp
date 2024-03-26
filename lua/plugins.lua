local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  { "themaxmarchuk/tailwindcss-colors.nvim", priority = 5 },
  'tpope/vim-rhubarb',
  { 'onsails/lspkind.nvim' },
  { 'ThePrimeagen/vim-be-good',              priority = -1 },
  { 'wintermute-cell/gitignore.nvim',        priority = 10, config = function() require("/plugin_config/gitignore") end },
  { "williamboman/mason-lspconfig.nvim" }, -- or
  {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
  },
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", },
    config = function()
      require("/plugin_config/nvim_tree")
    end
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

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim' },

      -- 'folke/neodev.nvim',
    },
  },

  {

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  { "windwp/nvim-ts-autotag", priority = 5 },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    priority = 5,
    config = function()
      vim.keymap.set("n", "<leader>et", function() require("trouble").toggle() end, { desc = "Toggle Diagnostics" })
      vim.keymap.set('n', '<leader>en', function() require("trouble").next({ skip_groups = true, jump = true }) end,
        { desc = "Diagnostcs Next" })
      -- jump to the previous item, skipping the groups
      vim.keymap.set('n', '<leader>eb', function() require("trouble").previous({ skip_groups = true, jump = true }) end,
        { desc = " Diagnostics Back" })
    end
  },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',     opts = {},                                                         lazy = false },
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
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("/plugin_config/colorizer")
    end
  },
  --[[ { "ellisonleao/gruvbox.nvim",      priority = 1000 } ]] --
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    config = function()
      vim.cmd [[colorscheme nightfox]]
      vim.cmd [[highlight Normal ctermbg=none]]
      vim.cmd [[highlight NonText ctermbg=none]]
      vim.cmd [[highlight Normal guibg=none]]
      vim.cmd [[highlight NonText guibg=none]]
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
    priority = 10000
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'nightfox',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
  },
  { "HiPhish/nvim-ts-rainbow2", config = function() require("/plugin_config/nvim-ts-rainbow") end, priority = 1 },
  { 'numToStr/Comment.nvim',    opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("/plugin_config/telescope")
    end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvimtools/none-ls.nvim' }, --config = --[[ function() require("/plugin_config/none_ls") end ]] },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ':TSUpdate',
    config = function()
      require("/plugin_config/tree_sitter")
    end
  },

  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("/plugin_config/harpoon")
    end
  },
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
  { "mbbill/undotree",       config = function() require("/plugin_config/undo_tree") end },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set("n", "ct", require("actions-preview").code_actions, { desc = "Code Telescope" })
    end,
    priority = 0
  }
  -- { import = 'custom.plugins' },
}, {})
