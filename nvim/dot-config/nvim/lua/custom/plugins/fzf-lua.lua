return {
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    config = function()

      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        winopts = {
          on_create = function(_)
            vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
            vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
          end
        },
        oldfiles = {
          cwd_only = true
        },
        keymap = {
          fzf = {
            ["ctrl-q"] = "select-all+accept",
          }
        }
      })

      -- buffers
      vim.keymap.set( "n", "<leader><space>", require("fzf-lua").buffers, { desc = "[ ] Buffers" })

      -- files
      vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "[f]iles" })
      vim.keymap.set("n", "<leader>sF", function()
        require("fzf-lua").files({root = false})
      end, { desc = "All [F]iles" })
      vim.keymap.set( "n", "<leader>?", require("fzf-lua").oldfiles, { desc = "[?] Recent files" })

      -- custom paths
      vim.keymap.set( "n", "<leader>sv", function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath('config') })
      end, { desc = "neo[v]im config" })
      vim.keymap.set("n", "<leader>sn", function()
        require("fzf-lua").files({cwd = '~/Library/CloudStorage/Dropbox/notes'})
      end, { desc = "[n]otes" })

      -- grep
      vim.keymap.set("n", "<leader>st", require("fzf-lua").live_grep_glob, { desc = "[t]ext (grep)" })
      vim.keymap.set("n", "<leader>sw", require("fzf-lua").grep_cword, { desc = "[w]ord" })
      vim.keymap.set("n", "<leader>sW", require("fzf-lua").grep_cWORD, { desc = "[W]ORD" })
      vim.keymap.set("v", "<leader>sv", require("fzf-lua").grep_visual, { desc = "[v]isual" })

      -- git
      vim.keymap.set("n", "<leader>sg", require("fzf-lua").git_status, { desc = "[g]it status" })
      vim.keymap.set("n", "<leader>sG", require("fzf-lua").git_commits, { desc = "[G]it commits" })
      vim.keymap.set("n", "<leader>ss", require("fzf-lua").git_stash, { desc = "git [s]tash" })
      vim.keymap.set("n", "<leader>sb", require("fzf-lua").git_branches, { desc = "git [b]ranches" })

      -- misc
      vim.keymap.set("n", "<leader>s:", require("fzf-lua").command_history, { desc = "command [h]istory" })
      vim.keymap.set("n", "<leader>sr", require("fzf-lua").resume, { desc = "[r]esume" })
      vim.keymap.set("n", "<leader>sh", require("fzf-lua").help_tags, { desc = "[h]elp" })
      vim.keymap.set("n", "<leader>sc", require("fzf-lua").colorschemes, { desc = "[c]olorscheme" })
      vim.keymap.set("n", "<leader>sk", require("fzf-lua").keymaps, { desc = "[k]eymaps" })
      vim.keymap.set("n", "<leader>sj", require("fzf-lua").jumps, { desc = "[j]umps" })
      vim.keymap.set("n", "<leader>sd", require("fzf-lua").diagnostics_document, { desc = "[d]iagnostics" })

    end
  },
}
