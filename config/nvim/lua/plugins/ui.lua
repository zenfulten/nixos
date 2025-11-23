return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			transparent = false,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_colors = function(colors)
				colors.bg_statusline = "NONE"
			end,
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		opts = {
			variant = "auto",
			transparent = false,
			italic_comments = true,
			borderless_pickers = false,
			highlights = {
				Comment = { fg = "#9c9c9c", bg = "NONE", italic = true },
			},
		},
	},
}
