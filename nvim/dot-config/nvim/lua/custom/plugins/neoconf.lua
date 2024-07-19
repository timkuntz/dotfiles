-- Configure neovim with global/local json setting files
return {
  'folke/neoconf.nvim',
  enabled = true,
  config = function()
    require('neoconf').setup {}
  end
}
