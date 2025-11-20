local M = {}

local map = vim.keymap.set

--- @param mode string The Vim mode (e.g., 'n', 'v', 'i')
--- @param lhs string The left-hand side key combination (e.g., '<leader>ld')
--- @param rhs_func function The function to call (e.g., vim.lsp.buf.definition)
--- @param desc string The description for the keymap
function M.lsp_map(mode, lhs, rhs_func, desc)
	map(mode, lhs, function()
		local ok, _ = pcall(rhs_func)
		if not ok then
			local command_name = desc:match("([^%s]+)$") or "LSP command"
			vim.notify(command_name .. " not available", vim.log.levels.WARN, { title = "LSP Keymap" })
		end
	end, { desc = desc })
end

M.map = map

return M
