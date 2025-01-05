return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function(_)
          vim.cmd "Neotree action=close"
        end,
        id = "close-at-the-open"
      }
    }
  },
  keys = {
    { "<leader>e", "<cmd>Neotree reveal action=focus position=float %p<cr>", desc = "explore" },
    { "<leader>be", "<cmd>Neotree position=left toggle=true source=buffers<cr>",    desc = "explore" },
    { "<leader>ge", "<cmd>Neotree position=left toggle=true source=git_status<cr>", desc = "explore" },
  },
}

