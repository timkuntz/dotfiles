return {
	"Wansmer/treesj",
	cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})
	end,
	keys = {
		-- { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
		-- { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
		{
			"<leader>cT",
			function()
				require("treesj").toggle()
			end,
			desc = "Toggle Code Block",
		},
	},
}

