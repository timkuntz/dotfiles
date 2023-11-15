return {
	"xiyaowong/telescope-emoji.nvim",
	keys = {
		{ "<leader>se", "<cmd>Telescope emoji<cr>", desc = "[S]earch [E]moji" },
	},
	init = function()
		require("telescope").load_extension("emoji")
	end,
}

