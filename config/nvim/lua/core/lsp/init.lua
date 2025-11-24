local M = {}

local function setup_rust_analyzer()
	local rust_nightly_path = vim.fn.expand("$HOME") .. "/.sdk/rust-nightly"

	vim.lsp.config.rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				sysroot = rust_nightly_path,
				check = {
					command = "cargo",
				},
				procMacro = {
					enable = true,
				},
			},
		},
	}
end

function M.setup()
	local servers = require("core.lsp.servers")

	setup_rust_analyzer()

	for _, lsp in ipairs(servers) do
		vim.lsp.enable(lsp)
	end

	local icons = require("core.icons")
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
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warn,
				[vim.diagnostic.severity.INFO] = icons.Info,
				[vim.diagnostic.severity.HINT] = icons.Hint,
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "ErrorMsg",
				[vim.diagnostic.severity.WARN] = "WarningMsg",
			},
		},
	})
end

return M
