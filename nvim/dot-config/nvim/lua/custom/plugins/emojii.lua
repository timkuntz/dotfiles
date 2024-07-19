return {
	"xiyaowong/telescope-emoji.nvim",
	enabled = false,
	keys = {
		{ "<leader>se", "<cmd>Telescope emoji<cr>", desc = "[e]moji" },
	},
	init = function()
		require("telescope").load_extension("emoji")
	end,
}

