return {
  {
    'VonHeikemen/lsp-zero.nvim',
    enabled = true,
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})
      end)

      -- setup nvim-lspconfig
      --    vim.opt.signcolumn = "yes"
      --    vim.api.nvim_create_autocmd("FileType", {
      --      pattern = "ruby",
      --      callback = function()
      -- vim.lsp.start {
      --   name = "rubocop",
      --   cmd = { "bundle", "exec", "rubocop", "--lsp" },
      -- }
      --      end,
      --    })

      lsp.setup()
    end,
  },
  {
    'sourcegraph/sg.nvim',
    enabled = true,
    config = function()
      require('sg').setup()
      require('sg.lsp').setup()
    end,
  }
}
