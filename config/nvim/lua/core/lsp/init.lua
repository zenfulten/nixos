-- File: lua/core/lsp/init.lua

local M = {}

function M.setup()
	local servers = require("core.lsp.servers")

	-- Setup each server listed in servers.lua
	for _, lsp in ipairs(servers) do
		vim.lsp.enable(lsp)
	end

	vim.diagnostic.config({
		virtual_text = false,
		virtual_lines = false,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = true,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "󰅚 ",
				[vim.diagnostic.severity.WARN] = "󰀪 ",
				[vim.diagnostic.severity.INFO] = "󰋽 ",
				[vim.diagnostic.severity.HINT] = "󰌶 ",
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "ErrorMsg",
				[vim.diagnostic.severity.WARN] = "WarningMsg",
			},
		},
	})
end

return M
