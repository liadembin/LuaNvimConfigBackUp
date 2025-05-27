return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  event='VeryLazy',
  dependencies = {
    -- Mason for LSP/DAP/Formatter management
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",   
    -- LSP UI improvements
    -- { "j-hui/fidget.nvim", opts = {} },
    -- Lua development improvements
    { "folke/neodev.nvim", opts = {} },
    -- null-ls for diagnostics, formatting, code actions
    -- {
    --   "nvimtools/none-ls.nvim",
    --   dependencies = {
    --     "nvimtools/none-ls-extras.nvim",
    --   },
    -- },
  },

  config = function()
    -- Set up LSP keymaps and highlight configuration when a language server attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        -- Navigation
        map("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>d", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        -- Diagnostics
        map("<leader>e", function()
          vim.diagnostic.open_float({ scope = "line" })
        end, "Line [E]rrors")
        -- Symbols
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        -- Actions
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>h", vim.lsp.buf.hover, "Hover Documentation")
        -- Document highlighting
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          -- Clean up on detach
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end
        -- Inlay hints (Neovim 0.10+)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          -- In Neovim 0.11, this can be toggled globally or per-buffer
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })
    -- LSP server setup
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    -- Server configurations
    local servers = {
      -- Python
      pyright = {},
      ruff = {},
      -- Web development
      --tsserver = {},
      html = {},
      cssls = {},
      tailwindcss = {},
      emmet_ls = {},
      svelte = {},
      biome = {},
      -- C/C++
      clangd = {},
      -- Vim
      vimls = {},
      -- CMake
      cmake = {},
      -- Lua
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }
    -- Ensure needed tools are installed via Mason
    local ensure_installed = vim.tbl_keys(servers or {})
    -- Add formatters and linters
    vim.list_extend(ensure_installed, {
      -- Lua
      "stylua",
      -- Python
      "black",       -- Formatter
      "ruff",        -- Fast Python linter
      "mypy",        -- Type checker
      "isort",       -- Import sorter
      "pyright",     -- LSP
      -- General
      "prettier",    -- Web formatting
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    -- Set up LSP servers
    vim.lsp.config('pyright',{})
    vim.lsp.enable('pyright',{})
    vim.lsp.enable('lua_ls',{})

      -- Configure format on save if desired (optional)
      -- on_attach = function(client, bufnr)
      --   if client.supports_method("textDocument/formatting") then
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format({ bufnr = bufnr })
      --       end,
      --     })
      --   end
      -- end,
    -- })
  end,
}
