return {
  "ibhagwan/fzf-lua",
  enabled = false,
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
    })

    -- buffers
    vim.keymap.set( "n", "<leader><space>", require("fzf-lua").buffers, { desc = "[ ] Buffers" })

    -- files
    vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "[f]iles" })
    vim.keymap.set( "n", "<leader>?", require("fzf-lua").oldfiles, { desc = "[?] Recent files" })

    -- neovim config
    local neovim_config = function()
      require("fzf-lua").files({ cwd = vim.fn.stdpath('config') })
    end
    vim.keymap.set( "n", "<leader>sc", neovim_config, { desc = "Neovim [c]onfiguration" })

    -- grep
    vim.keymap.set("n", "<leader>st", require("fzf-lua").live_grep_glob, { desc = "[t]ext (grep)" })
    vim.keymap.set("n", "<leader>sw", require("fzf-lua").grep_cword, { desc = "[w]ord" })
    vim.keymap.set("n", "<leader>sW", require("fzf-lua").grep_cWORD, { desc = "[W]ORD" })
    vim.keymap.set("n", "<leader>sv", require("fzf-lua").grep_visual, { desc = "[v]isual" })

    -- git
    vim.keymap.set("n", "<leader>sg", require("fzf-lua").git_status, { desc = "[g]it status" })
    vim.keymap.set("n", "<leader>sG", require("fzf-lua").git_status, { desc = "[G]it commits" })
    vim.keymap.set("n", "<leader>ss", require("fzf-lua").git_status, { desc = "git [s]tash" })
    vim.keymap.set("n", "<leader>sb", require("fzf-lua").git_branches, { desc = "git [b]ranches" })

    -- misc
    vim.keymap.set("n", "<leader>sr", require("fzf-lua").resume, { desc = "[r]esume" })
    vim.keymap.set("n", "<leader>sh", require("fzf-lua").help_tags, { desc = "[h]elp" })
    vim.keymap.set("n", "<leader>sC", require("fzf-lua").colorschemes, { desc = "[C]olorscheme" })
    -- vim.keymap.set("n", "<leader>st", require("fzf-lua").tags, { desc = "[t]ags" })

    vim.keymap.set( "n", "<leader>sd", require("fzf-lua").diagnostics_document, { desc = "[d]iagnostics" })

  end
}

