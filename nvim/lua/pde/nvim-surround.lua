return {
  "kylechui/nvim-surround",
  enable = config.pde.nvim_surround,
  init = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
}

