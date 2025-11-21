local sections = require("core.lualine.sections")

local M = {}

function M.setup()
	local lualine = require("lualine")
	local current_cs = vim.g.colors_name
	local lualine_theme = current_cs or "auto"

	lualine.setup({
		options = {
			theme = lualine_theme,
			icons_enabled = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			globalstatus = true,
		},
		sections = sections.active,
		winbar = sections.winbar,
		inactive_winbar = sections.inactive_winbar,
	})
end

return M
