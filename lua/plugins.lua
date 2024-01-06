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

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  -- { 'codota/tabnine-nvim',     build = "pwsh.exe -file .\\dl_binaries.ps1" },
  -- Git related plugins
  'tpope/vim-fugitive',
  { "themaxmarchuk/tailwindcss-colors.nvim", priority = 5 },
  'tpope/vim-rhubarb',
  { 'onsails/lspkind.nvim' },
  --{ 'akinsho/toggleterm.nvim', version = "*",                              config = true },
  { 'ThePrimeagen/vim-be-good',              priority = -1 },
  { 'wintermute-cell/gitignore.nvim',        priority = 10, config = function() require("/plugin_config/gitignore") end },
  { "williamboman/mason-lspconfig.nvim" }, -- or
  -- { 'akinsho/toggleterm.nvim', version = "*", opts = { --[[ things you want to change go here]] } },
  -- Detect tabstop and shiftwidth automatically
  {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
  },
  'tpope/vim-sleuth',
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
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim' },
      -- Additional lua configuration, makes nvim stuff amazing!
      --
      'folke/neodev.nvim',
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
  "windwp/nvim-ts-autotag",
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {}, lazy = false },
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
  { "EdenEast/nightfox.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      --transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      tokyonight.load()
    end,
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

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  -- },
  "HiPhish/nvim-ts-rainbow2",
  -- "gc" to comment visual regions/lines
  'Mofiqul/dracula.nvim',
  { "navarasu/onedark.nvim" },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
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
  { 'nvimtools/none-ls.nvim', config = function() require("/plugin_config/none_ls") end },
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
  { "mbbill/undotree",        config = function() require("/plugin_config/undo_tree") end },

  --{ "tpope/vim-dadbod",                     lazy = true },
  --{ "kristijanhusak/vim-dadbod-ui",         lazy = true },
  --{ "kristijanhusak/vim-dadbod-completion", lazy = true },

  { import = 'custom.plugins' },
}, {})
