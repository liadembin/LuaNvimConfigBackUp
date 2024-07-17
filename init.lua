local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
require("plugins/sets")
require("lazy").setup({
	{
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme duskfox")
		end,
	},
	"tpope/vim-sleuth",
	"tpope/vim-rhubarb",
	{ "themaxmarchuk/tailwindcss-colors.nvim", priority = 5 },
	{ "numToStr/Comment.nvim", opts = {}, priority = 100000000 },
	--"tpope/vim-commentary",
	{
		"lukas-reineke/indent-blankline.nvim",
	},

	require("plugins/treesitter"),
	require("plugins/telescope"),
	require("plugins/luasnip"),
	require("plugins/lsp"),
	require("plugins/conform"),
	require("plugins/spotify"),
	require("plugins/aerial"),
	{

		"wintermute-cell/gitignore.nvim",
		priority = 10,
		config = function()
			vim.keymap.set("n", "<leader>gi", ":Gitignore<CR>")
		end,
	},
	require("plugins/rainbow_delimiters"),
	{ "windwp/nvim-ts-autotag", priority = 5 },
	-- {
	-- 	"folke/trouble.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	opts = {
	-- 		-- your configuration comes here
	-- 		-- or leave it empty to use the default settings
	-- 		-- refer to the configuration section below
	-- 	},
	-- 	priority = 5,
	-- 	config = function()
	-- 		vim.keymap.set("n", "<leader>dt", function()
	-- 			require("trouble").toggle()
	-- 		end, { desc = "Toggle Diagnostics" })
	-- 		vim.keymap.set("n", "<leader>dn", function()
	-- 			require("trouble").next({ skip_groups = true, jump = true })
	-- 		end, { desc = "Diagnostcs Next" })
	-- 		-- jump to the previous item, skipping the groups
	-- 		vim.keymap.set("n", "<leader>db", function()
	-- 			require("trouble").previous({ skip_groups = true, jump = true })
	-- 		end, { desc = " Diagnostics Back" })
	-- 	end,
	-- },
	require("plugins/nvim_tree"),
	{
		"akinsho/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
	},
	{ "folke/which-key.nvim", opts = {}, priority = 1 },
})
