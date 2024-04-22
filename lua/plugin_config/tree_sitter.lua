require('nvim-treesitter.configs').setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'rust',
        'tsx',
        'typescript',
        'vimdoc',
        'vim',
        'javascript',
    },
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    sync_install = false,

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the goto_next_start = {
            goto_next_start = {
                ['gf'] = '@function.outer',
                ['oc'] = '@class.outer',
            },
            goto_next_end = {
                ['ef'] = '@function.outer',
                ['ec'] = '@class.outer',
            },
            goto_previous_start = {
                ['sf'] = '@function.outer',
                ['sc'] = '@class.outer',
            },
            goto_previous_end = {
                ['pu'] = '@function.outer',
                ['pc'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_previous = {
                ['<leader>ps'] = '@parameter.inner',
            },
            swap_next = {
                ['<leader>pp'] = '@parameter.inner',
            },
        },
        autotag = {
            enable = true,
        },
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['ap'] = '@parameter.outer',
                ['ip'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['io'] = '@conditional.inner',
                ['ao'] = '@conditional.outer',
                ['in'] = '@loop.inner',
                ['al'] = '@loop.outer',
                ['a/'] = '@comment.outer',
            },
        },
    },
})

-- Diagnostic keymas
