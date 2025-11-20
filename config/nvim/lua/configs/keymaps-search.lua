local util = require("utils.keymaps")
local safe_map = util.safe_map -- The safe-calling map function

local builtin = require("telescope.builtin")

-- Find Files
safe_map("n", "<leader>ff", builtin.find_files, "Find Files")

-- Smart Open Files (requires Telescope Smart Open extension)
safe_map("n", "<leader>fF", function()
	local telescope = require("telescope")
	return telescope.extensions.smart_open.smart_open()
end, "Smart Open Files")

-- Live Grep (Search in Project)
safe_map("n", "<leader>fg", builtin.live_grep, "Live Grep (Project)")

-- Live Grep in Current Directory
safe_map("n", "<leader>fG", function()
	return builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
end, "Live Grep (Directory)")

-- Find Buffers
safe_map("n", "<leader>fb", builtin.buffers, "Find Buffers")

-- Find Old Files (Recent files)
safe_map("n", "<leader>fo", builtin.oldfiles, "Find Old Files")
safe_map("n", "<leader>bh", builtin.oldfiles, "Recent Files") -- Duplication removed

-- Resume Last Search
safe_map("n", "<leader>fr", builtin.resume, "Resume Last Search")

-- Fuzzy Find in Current Buffer
safe_map("n", "<leader>fz", builtin.current_buffer_fuzzy_find, "Fuzzy Find in Current Buffer")
safe_map("n", "<leader>?", builtin.current_buffer_fuzzy_find, "Search in Current Buffer") -- Duplication removed

-- Find Help Tags
safe_map("n", "<leader>fh", builtin.help_tags, "Find Help Tags")

-- Find Man Pages
safe_map("n", "<leader>fm", builtin.man_pages, "Find Man Pages")

-- Find Keymaps
safe_map("n", "<leader>fk", builtin.keymaps, "Find Keymaps")

-- Find Commands
safe_map("n", "<leader>fc", builtin.commands, "Find Commands")

-- List File Types
safe_map("n", "<leader>bt", builtin.filetypes, "List File Types")

-- Find string under cursor (Default setting uses '<cword>')
safe_map("n", "<leader>ft", builtin.grep_string, "Find String Under Cursor") -- Renamed description for clarity

-- Find Word Under Cursor (Explicit <cword> search)
safe_map("n", "<leader>fT", function()
	return builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, "Find Word Under Cursor")
safe_map("n", "<leader>sw", function()
	return builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, "Search Word Under Cursor") -- Duplication preserved for different leader key mapping

-- Find Symbols (e.g., tags)
safe_map("n", "<leader>fs", builtin.symbols, "Find Symbols")

-- Find Workspace Symbols
safe_map("n", "<leader>fS", builtin.lsp_workspace_symbols, "Find Workspace Symbols")

-- Search in Project (Live Grep)
safe_map("n", "<leader>/", builtin.live_grep, "Search in Project")
safe_map("n", "<leader>sp", builtin.live_grep, "Search in Project") -- Duplication preserved

-- Search Word Under Cursor (using <cword>)
safe_map("n", "<leader>*", function()
	return builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, "Search Word Under Cursor")

-- Search Visual Selection
safe_map("v", "<leader>*", function()
	local text = vim.fn.getbufline(0, "v")[1] -- Using a reliable way to get visual selection
	return builtin.grep_string({ search = text })
end, "Search Visual Selection")
