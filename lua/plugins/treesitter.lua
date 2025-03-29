return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	opts = {
		ensure_installed = {
			"c",
			"cpp",
			"go",
			--"lua",
			"python",
			"rust",
			"tsx",
			"typescript",
			"vimdoc",
			"vim",
			"javascript",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<M-space>",
			},
		},
		textobjects = {
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["gf"] = "@function.outer",
					["co"] = "@class.outer",
				},
				goto_next_end = {
					["ef"] = "@function.outer",
					["ec"] = "@class.outer",
				},
				goto_previous_start = {
					["pf"] = "@function.outer",
					["pc"] = "@class.outer",
				},
				goto_previous_end = {
					["pu"] = "@function.outer",
					["pc"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_previous = {
					["<leader>pn"] = "@parameter.inner",
				},
				swap_next = {
					["<leader>pb"] = "@parameter.inner",
				},
			},
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["ap"] = "@parameter.outer",
					["ip"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["io"] = "@conditional.inner",
					["ao"] = "@conditional.outer",
					["in"] = "@loop.inner",
					["al"] = "@loop.outer",
					["a/"] = "@comment.outer",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup(opts)
	end,
	lazy=1000
}
