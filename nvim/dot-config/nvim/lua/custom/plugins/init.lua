return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- {
  -- "junegunn/fzf.vim",
  -- 	dependencies = { "junegunn/fzf" },
  -- },

  -- Autocompletion
  {
    'saghen/blink.cmp',
  },

  -- "gc" to comment visual regions/lines
  {
    'echasnovski/mini.comment',
    enabled = false,
    config = function()
      require('mini.comment').setup()
    end,
  }
}

