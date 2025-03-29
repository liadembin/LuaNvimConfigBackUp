-- Initialize mason.nvim to manage external tools
require("mason").setup()

-- Define LSP server configurations
local servers = {
    clangd = {
        cmd = { "clangd", "--background-index" },
        root_markers = { "compile_commands.json", "compile_flags.txt" },
        filetypes = { "c", "cpp" },
    },
    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
        filetypes = { "python" },
    },
    rust_analyzer = {
        cmd = { "rust-analyzer" },
        root_markers = { "Cargo.toml", ".git" },
        filetypes = { "rust" },
    },
    lua_ls = {
        cmd = { "lua-language-server" },
        root_markers = { ".luarc.json", ".luacheckrc", ".git" },
        filetypes = { "lua" },
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    },
    -- Add other server configurations as needed
}

-- Configure each LSP server
for name, config in pairs(servers) do
    vim.lsp.config(name, config)
end

-- Enable the configured LSP servers
for name, _ in pairs(servers) do
    vim.lsp.enable(name)
end

-- Optional: Set up keybindings and autocommands for LSP features
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = function(event)
        local buf = event.buf
        local opts = { buffer = buf, desc = "LSP: " }

        -- Set up keybindings for LSP features
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "dn", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "db", vim.diagnostic.goto_next, opts)

        -- Autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = buf,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
})


