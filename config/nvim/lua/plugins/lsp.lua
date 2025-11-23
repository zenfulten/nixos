-- File: lua/plugins/lsp.lua

return {
	-- 1. Mason plugin for managing LSP servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},

	-- 2. Mason-Lspconfig for easy server integration
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		cmd = { "LspInstall", "LspUninstall" },
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			auto_install = true,
		},
	},

	-- 3. nvim-lspconfig for the actual LSP setup
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		opts = { diagnostics = { virtual_text = false } },
		config = function()
			require("core.lsp").setup()
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "InsertEnter",
		priority = 1000,
		opts = {
			preset = "simple",
			transparent_bg = true,
			icons = {
				Error = "󰅚 ", -- Error icon
				Warn = "󰀪 ", -- Warning icon
				Info = "󰋽 ", -- Info icon
				Hint = "󰌶 ", -- Hint icon
			},
			hi = {
				error = "DiagnosticError", -- Highlight for error diagnostics
				warn = "DiagnosticWarn", -- Highlight for warning diagnostics
				info = "DiagnosticInfo", -- Highlight for info diagnostics
				hint = "DiagnosticHint", -- Highlight for hint diagnostics
				arrow = "NonText", -- Highlight for the arrow pointing to diagnostic
				background = "CursorLine", -- Background highlight for diagnostics
				mixing_color = "Normal", -- Color to blend background with (or "None")
			},
			options = {
				show_all_diags_on_cursorline = true,
				severity = {
					vim.diagnostic.severity.ERROR,
					vim.diagnostic.severity.WARN,
					vim.diagnostic.severity.INFO,
					vim.diagnostic.severity.HINT,
				},
			},
		},
	},
}
