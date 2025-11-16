local map = vim.keymap.set

-- ## Terminal & External Tools
map("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
map("t", "<esc><esc>", "<cmd>ToggleTerm<cr>", { desc = "Exit ToggleTerm" })

-- ## Todo Comments
map("n", "<leader>I", ":TodoTelescope<CR>", { desc = "Todo Telescope" })
