return {
	'tpope/vim-rails',
	dependencies = {
		'tpope/vim-bundler',
		'vim-ruby/vim-ruby',
	},
	config = function()
		local keymap = {
      { "ga", "<cmd>:A<cr>", desc = "go [a]ternate", nowait = false, remap = false },
    }
    require("which-key").add(keymap)
	end
}
