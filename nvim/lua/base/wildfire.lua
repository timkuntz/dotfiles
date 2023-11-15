-- https://github.com/SUSTech-data/wildfire.nvim
-- incremental selection
return {
  "SUSTech-data/wildfire.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("wildfire").setup()
  end,
}
