local servers = {
  pyright = {},
  ruff = {},
  clangd = {
    root_markers = { '.clang-format', 'compile_commands.json' },
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
          }
        }
      }
    }
  },
  
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
print("Setting up LSP servers...")
for server_name, config in pairs(servers) do
  vim.lsp.config[server_name] = config
  vim.lsp.enable(server_name)
end
