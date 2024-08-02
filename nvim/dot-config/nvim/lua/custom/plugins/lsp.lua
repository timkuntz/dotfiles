return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neoconf.nvim',
    },
    init = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
      })

      -- then setup your lsp server as usual
      local lspconfig = require('lspconfig')

      -- example to setup lua_ls and enable call snippets
      lspconfig.lua_ls.setup({
	settings = {
	  Lua = {
	    completion = {
	      callSnippet = "Replace"
	    }
	  }
	}
      })
    end,
    enabled = true,
    tag = 'v0.1.8',
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    enabled = true,
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      -- {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/lsp.md#commands
      vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(_)
	  local keymap = {
	    { "gA", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "LSP Action" },
	    { "gF", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "LSP Format" },
	    { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "LSP Declaration" },
	    { "gK", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "LSP Hover" },
	    { "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "LSP Rename" },
	    { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "LSP Definition" },
	    { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "LSP Implentation" },
	    { "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "LSP Type Definition" },
	    { "gr", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "LSP References" },
	    { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "LSP Signature Help" },
	    { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "LSP Previous Diagnostic" },
	    { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "LSP Next Diagnostic" },
	  }
	  require("which-key").add(keymap)
	end
      })

      -- lsp format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rb",
	callback = function()
	  vim.lsp.buf.format()
	end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lsp_config = require("lspconfig")

      lsp_config.ruby_lsp.setup {
	capabilities = capabilities,
	cmd = {os.getenv("HOME") .. "/.asdf/shims/ruby-lsp"},
      }

      lsp.setup()
    end,
  }
}
