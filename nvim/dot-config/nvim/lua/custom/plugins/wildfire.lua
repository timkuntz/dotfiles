-- https://github.com/SUSTech-data/wildfire.nvim
-- incremental selection using <CR> and <BS>
return {
  "SUSTech-data/wildfire.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("wildfire").setup()
  end,
}
