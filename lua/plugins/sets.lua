vim.g.python_host_skip_check = 1
vim.g.python3_host_skip_check = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.colorcolumn = 90
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = -"/.vim/undodir"
vim.opt.undofile = true
local uname = vim.loop.os_uname()

_G.OS = uname.sysname
_G.IS_WINDOWS = _G.OS:find('Windows') and true or false
if _G.IS_WINDOWS then 
    vim.opt.undodir = "C:\\Users\\liad8\\.vim"
else 
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = false
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.isfname:append("@-@")

vim.opt.updatetime = 100

vim.opt.colorcolumn = "80"

-- Set highlight on search
--vim.keymap.set('n', '<leader>mt', ':Format')
-- Make line numbers default
vim.wo.number = true
-- Enable mouse mode
vim.o.mouse = "a"
-- -- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = { "*" },
  command = [[call setreg("@", getreg("+"))]],
})


  -- sync with system clipboard on focus
  vim.api.nvim_create_autocmd({ "FocusLost" }, {
    pattern = { "*" },
    command = [[call setreg("+", getreg("@"))]], 
  })
vim.opt.swapfile = false
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Enable break nindent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
vim.o.background = "dark"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>F", function()
	vim.lsp.buf.format()
end, { desc = "[P]rettify [F]ile" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>of",
	':!start "" %<CR><CR>',
	{ noremap = true, silent = true, desc = "Open file with associated program" }
)

-- Reveal current directory in file explorer
vim.api.nvim_set_keymap(
	"n",
	"<leader>ox",
	":!start explorer.exe .<CR><CR>",
	{ noremap = true, silent = true, desc = "Open file explorer in current dirr" }
)

-- Open cmd in current directory
vim.api.nvim_set_keymap(
	"n",
	"<leader>oc",
	":!start cmd /K cd %:p:h<CR><CR>",
	{ noremap = true, silent = true, desc = "Open Cmd in this dir" }
)
-- vim.opt.foldenable = false
-- vim.opt.foldmethod = "manual"
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Set the g:python3_host_prog variable to specify the Python 3 host program
vim.g.python3_host_prog = "C:\\Program Files\\Python311\\python.exe"
vim.o.statuscolumn = ""
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
