local M = {}

function M.main()
	print("Spotify module loaded.")
end

function M.setup()
	local client_id = vim.fn.input("Enter client ID: ")
	if client_id == "" then
		print("Client ID cannot be empty.")
		return
	end

	local client_secret = vim.fn.input("Enter client secret: ")
	if client_secret == "" then
		print("Client secret cannot be empty.")
		return
	end

	-- Run the Python server using jobstart
	vim.fn.jobstart({ "python3", "server.py", client_id, client_secret }, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data, _)
			if data then
				print("stdout:")
				print(table.concat(data, "\n"))
			end
		end,
		on_stderr = function(_, data, _)
			if data then
				print("stderr:")
				print(table.concat(data, "\n"))
			end
		end,
		on_exit = function(_, code, _)
			print("Python server exited with code: " .. code)
		end,
	})
end

vim.api.nvim_create_user_command("RunPythonServer", function()
	M.setup()
end, { desc = "Run the Python server with client ID and secret" })

return M
