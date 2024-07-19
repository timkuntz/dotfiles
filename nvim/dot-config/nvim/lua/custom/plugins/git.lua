local github_open = function()
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd(row .. ":GBrowse")
end

local github_copy = function()
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd(row .. ":GBrowse!")
end

return {
	-- Git related actions
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		enabled = true,
		keys = {
			{ "<leader>gb", "<Cmd>Git blame<Cr>", desc = "blame" },
			{ "<leader>gd", "<Cmd>Gvdiffsplit!<Cr>", desc = "diff" },
			{ "<leader>gl", "<Cmd>Git log --oneline<Cr>", desc = "log (quickfix)" },
			{ "<leader>gs", "<Cmd>Git!<Cr>", desc = "status" },
			{ "<leader>gk", "<Cmd>help fugitive-maps<Cr>", desc = "keymaps (fugitive)" },
		},
	},
	-- git Hub related actions
	{
		"tpope/vim-rhubarb",
		enabled = true,
		keys = {
			{ "<leader>gg", github_open, desc = "github" },
			{ "<leader>gh", github_copy, desc = "github (copy)" },
		},
	},
	-- Adds git releated signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
}

