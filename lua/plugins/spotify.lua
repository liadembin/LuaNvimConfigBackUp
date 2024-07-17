return {
	"KadoBOT/nvim-spotify",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		local spotify = require("nvim-spotify")

		spotify.setup({
			-- default opts
			status = {
				update_interval = 10000, -- the interval (ms) to check for what's currently playing
				format = "%s %t by %a", -- spotify-tui --format argument
			},
		})

		vim.api.nvim_set_keymap("n", "<leader>sn", "<Plug>(SpotifySkip)", { silent = true, desc = "[S]potify [N]ext" }) -- Skip the current track
		vim.api.nvim_set_keymap(
			"n",
			"<leader>sp",
			"<Plug>(SpotifyPause)",
			{ silent = true, desc = "[S}potify [P]ause" }
		) -- Pause/Resume the current track
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ss",
			"<Plug>(SpotifySave)",
			{ silent = true, desc = "[S]potify [S]ave (lib)" }
		) -- Add the current track to your library
		vim.api.nvim_set_keymap("n", "<leader>so", ":Spotify<CR>", { silent = true, desc = "[S]potify [O]pen" }) -- Open Spotify Search window
		vim.api.nvim_set_keymap(
			"n",
			"<leader>sd",
			":SpotifyDevices<CR>",
			{ silent = true, desc = "[S]potify [D]evices" }
		) -- Open Spotify Devices window
		vim.api.nvim_set_keymap("n", "<leader>sb", "<Plug>(SpotifyPrev)", { silent = true, desc = "[S]potify Back" }) -- Go back to the previous track
		vim.api.nvim_set_keymap(
			"n",
			"<leader>sh",
			"<Plug>(SpotifyShuffle)",
			{ silent = true, desc = "[S]potify S[H]uffle" }
		) -- Toggles shuffle mode
	end,
	run = "make",
}
