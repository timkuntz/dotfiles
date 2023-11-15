-- Configure neovim with global/local json setting files
return {
  'folke/neoconf.nvim',
  enabled = false,
  dependencies = {
    'neovim/nvim-lspconfig'
  },
  config = function()
    require('neoconf').setup {}
  end
}
