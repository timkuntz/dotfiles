return {
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	-- {
	-- 	-- Add indentation guides even on blank lines
	-- 	-- See `:help indent_blankline.txt`
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {
	-- 		indent = { char = "┊" },
	-- 		scope = { exclude = { filetypes = {'startify'}}},
	-- 	},
	-- },

	-- "gc" to comment visual regions/lines
	{
		'echasnovski/mini.comment',
		config = function()
			require('mini.comment').setup()
		end,
	}
}

