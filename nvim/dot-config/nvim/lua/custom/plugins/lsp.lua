-- resources for manually setting up LSP if desired
-- https://mason-registry.dev/registry/list#elixir-ls - registry of language servers
-- https://github.com/elixir-lsp/elixir-ls/releases/tag/v0.26.2 - elixir-ls release
-- ~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh - location of elixir-ls
-- https://lsp-zero.netlify.app/blog/lsp-config-without-plugins - lsp-zero blog post on setting up LSP in nvim 11.*

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neoconf.nvim',
    },
    init = function()
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
      'williamboman/mason.nvim',           -- Optional
      'williamboman/mason-lspconfig.nvim', -- Optional

      -- Autocompletion
      'saghen/blink.cmp',
      'L3MON4D3/LuaSnip',     -- Required
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
            { "gs", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", desc = "LSP Symbols" },
            { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "LSP References" },
            { "gS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "LSP Signature Help" },
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

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp_config = require("lspconfig")

      lsp_config.ruby_lsp.setup {
        capabilities = capabilities,
        cmd = {os.getenv("HOME") .. "/.asdf/shims/ruby-lsp"},
      }

      lsp.setup()
    end,
  }
}
