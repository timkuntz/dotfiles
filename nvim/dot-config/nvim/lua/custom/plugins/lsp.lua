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
	callback = function(event)
	  local keymap = {
	    g = {
	      A = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Action" },
	      F = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "LSP Format" },
	      D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP Declaration" },
	      K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover" },
	      R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename" },
	      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "LSP Definition" },
	      i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP Implentation" },
	      o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "LSP Type Definition" },
	      r = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "LSP References" },
	      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "LSP Signature Help" },
	    },
	  }
	  keymap['['] = {
	    d = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "LSP Previous Diagnostic" }
	  }
	  keymap[']'] = {
	    d = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "LSP Next Diagnostic" }
	  }
	  require("utils").register_keys(keymap, {
	    prefix = "",
	    buffer = event.buf
	  })
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
