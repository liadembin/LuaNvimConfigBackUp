local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  -- require("tailwindcss-colors").buf_attach(bufnr)
  -- print("rn")
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>li', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>ld', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ls', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('<leader>h', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  vimls = {},
  tailwindcss = {},
  --pylyzer = {},
  svelte = {},
  prismals = {},
  asm_lsp = {},
  html = {},
  jsonls = {},
  omnisharp = {},
  cssls = {},
  emmet_ls = {},
  rome = {},
  pylsp = {

  },
  jedi_language_server = {},
  cmake = {},
  -- pylama = {},
  -- pydocstyle = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  --black = {}
}

require("mason").setup()

require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
}
local lsp_config = require("lspconfig")
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local mason_lspconfig = require 'mason-lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
local get_servers = require('mason-lspconfig').get_installed_servers
for _, server_name in ipairs(get_servers()) do
  lsp_config[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
end



require('lspkind').init({
  -- DEPRECATED (use mode instead): enables text annotations
  --
  -- default: true
  -- with_text = true,

  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = 'text_symbol',
  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = 'codicons',

  -- override preset symbols
  --
  -- default: {}
  symbol_map = {
    Text = "󰉿 text",
    Method = "󰆧 method",
    Function = "󰊕 function",
    Constructor = " contructor",
    Field = "󰜢 field",
    Variable = "󰀫 variable",
    Class = "󰠱 class",
    Interface = "  interface",
    Module = "  module",
    Property = "󰜢  Property",
    Unit = "󰑭  Unit",
    Value = "󰎠  Value",
    Enum = "  Enum",
    Keyword = "󰌋  Keyword",
    Snippet = "  Snippet",
    Color = "󰏘  Color",
    File = "󰈙  File",
    Reference = "󰈇  Reference",
    Folder = "󰉋  Folder",
    EnumMember = " EnumMember",
    Constant = "󰏿  Constant",
    Struct = "󰙅  Struct",
    Event = " Event",
    Operator = "󰆕  Operator",
    TypeParameter = "Type Paramater",
  },
})


vim.keymap.set('n', 'pd', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', 'nd', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- but im Lazy and dont know enought nvim yet
