local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.diagnostics.clang_check,
    -- null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.csharpier,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "mysql" }, -- change to your dialect
    }),
    null_ls.builtins.code_actions.cspell,
    null_ls.builtins.code_actions.eslint_d,

    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.code_actions.impl
    ,
  },

  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
