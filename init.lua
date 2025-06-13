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
	"dstein64/vim-startuptime",
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	config = function()
	-- 		vim.cmd("colorscheme duskfox")
	-- 	end,
	-- },
	-- {
	-- 	"embark-theme/vim",
	-- 	as = "embark",
	-- 	config = function()
	-- 		vim.g.embark_terminal_italics = 1
	-- 		vim.cmd("colorscheme embark")
	-- 	end,
	-- },
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	config = function()
	-- 		-- require("plugins/lualine")
	-- 	end,
	-- },
	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme dracula")
		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	"tpope/vim-sleuth",
	{ "github/copilot.vim", priority = 1, event = "InsertEnter" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	require("plugins/treesitter"),
	require("plugins/telescope"),
	require("plugins/lsp"),
	{ "echasnovski/mini.nvim", version = "*" },
	{ "folke/which-key.nvim", opts = {}, priority = 1 },
})
require("plugins/spt")
-- require("plugins/lsp_new")
