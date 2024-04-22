local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    }),
})

local lspkind = require('lspkind')
cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 150,
            ellipsis_char = '...',
            before = function(entry, vim_item)
                -- local icons = lspkind.presets.default
                local icons = { -- {{{
                    Text = '󰉿 text',
                    Method = '󰆧 method',
                    Function = '󰊕 function',
                    Constructor = ' contructor',
                    Field = '󰜢 field',
                    Variable = '󰀫 variable',
                    Class = '󰠱 class',
                    Interface = '  interface',
                    Module = '  module',
                    Property = '󰜢  Property',
                    Unit = '󰑭  Unit',
                    Value = '󰎠  Value',
                    Enum = '  Enum',
                    Keyword = '󰌋  Keyword',
                    Snippet = '  Snippet',
                    Color = '󰏘  Color',
                    File = '󰈙  File',
                    Reference = '󰈇  Reference',
                    Folder = '󰉋  Folder',
                    EnumMember = ' EnumMember',
                    Constant = '󰏿  Constant',
                    Struct = '󰙅  Struct',
                    Event = ' Event',
                    Operator = '󰆕  Operator',
                    TypeParameter = 'Type Paramater',
                } -- }}}
                -- vim_item.kind = '[LSP] ' and icons[vim_item.kind]
                vim_item.kind = '[LSP] ' .. (vim_item.kind and icons[vim_item.kind] or '')
                -- Preserve original menu value
                local original_menu = vim_item.menu or ''

                -- Add [LSP] (icon) (desc) format
                local lsp_prefix = vim_item.source
                        and vim_item.source.name
                        and '[' .. vim_item.source.name .. '] '
                    or ''
                local icon = vim_item.kind and vim_item.kind .. ' ' or ''
                local desc = vim_item.menu and '(' .. vim_item.menu .. ')' or ''
                local original_desc = original_menu ~= '' and '(' .. original_menu .. ')' or ''
                vim_item.menu = lsp_prefix .. icon .. original_desc .. ' ' .. desc

                return vim_item
            end,
        }),
    },
})
