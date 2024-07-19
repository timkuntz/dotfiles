return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  keys = {
    { "<leader>sD", "<cmd>DevdocsOpen<cr>", desc = "[D]evdocs" },
  },
}
