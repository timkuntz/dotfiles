-- Fuzzy Finder (files, lsp, etc)
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = true,
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/aerial.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    init = function()
      -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local actions_layout = require("telescope.actions.layout")
      local transform_mod = require("telescope.actions.mt").transform_mod
      local lga_actions = require("telescope-live-grep-args.actions")
      local custom_actions = transform_mod({
        -- VisiData
        visidata = function(prompt_bufnr)
          -- Get the full path
          local content = require("telescope.actions.state").get_selected_entry()
          if content == nil then
            return
          end
          local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

          -- Close the Telescope window
          require("telescope.actions").close(prompt_bufnr)

          -- Open the file with VisiData
          local utils = require("utils")
          utils.open_term("vd " .. full_path, { direction = "float" })
        end,

        pick = function(pb)
          local picker = action_state.get_current_picker(pb)
          local multi = picker:get_multi_selection()
          actions.select_default(pb) -- the normal enter behaviour
          for _, j in pairs(multi) do
            if j.path ~= nil then -- is it a file -> open it as well:
              vim.cmd(string.format("%s %s", "edit", j.path))
            end
          end
        end,

        -- the 'tab' key is the native key for toggling selections
        -- but I find <C-,> feels better for me
        multi_select = function()
          local bufnr = vim.api.nvim_get_current_buf()
          actions.toggle_selection(bufnr)
        end,

      })

      local mappings = {
        i = {
          ["<CR>"] = custom_actions.pick,
          ["<C-,>"] = custom_actions.multi_select,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["?"] = actions_layout.toggle_preview,
          ["<C-s>"] = custom_actions.visidata,
          ["<C-b>"] = actions.delete_buffer,
        },
        n = {
          ["<CR>"] = custom_actions.pick,
          ["<C-,>"] = custom_actions.multi_select,
          ["s"] = custom_actions.visidata,
          ["<A-f>"] = custom_actions.file_browser,
          ["<C-d>"] = actions.delete_buffer,
          ["<C-b>"] = actions.delete_buffer,
        },
      }

      require("telescope").setup({
        defaults = {
          mappings = mappings,
        },
        extensions = {},
      })

      -- Enable telescope fzf native, if installed
      -- pcall(require("telescope").load_extension, "fzf")

      -- See `:help telescope.builtin`
      vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[f]iles" })
      vim.keymap.set("n", "<leader>sv", function()
        require("telescope.builtin").find_files({cwd = vim.fn.stdpath('config')})
      end, { desc = "[v]im" })

      -- requires the executable 'rg'; brew install rg
      vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "by [g]rep" })
      vim.keymap.set("n", "<leader>sG", function()
        require("telescope.builtin").live_grep({ glob_pattern = "!*test.rb", glob_pattern = "!**/test/**" })
      end, { desc = "by [G]rep with filters" })
      vim.keymap.set(
        "n",
        "<leader>sw",
        require("telescope.builtin").grep_string,
        { desc = "current [w]ord" }
      )
      vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[r]esume" })
      vim.keymap.set("n", "<leader>so", "<cmd>Telescope aerial<cr>", { desc = "code [o]utline" })
      vim.keymap.set(
        "n",
        "<leader><space>",
        require("telescope.builtin").buffers,
        { desc = "[ ] Find existing buffers" }
      )
      vim.keymap.set(
        "n",
       "<leader>?",
        require("telescope.builtin").oldfiles,
        { desc = "[?] Find recently opened files" }
      )

      vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[h]elp" })
      vim.keymap.set(
        "n",
        "<leader>sd",
        require("telescope.builtin").diagnostics,
        { desc = "[d]iagnostics" }
      )
      vim.keymap.set("n", "<leader>st", require("telescope.builtin").tags, { desc = "[t]ags" })
      vim.keymap.set("n", "<leader>sc", function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
      end, { desc = "[c]olorscheme" })

      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
      vim.keymap.set("n", "<leader>sW", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "current [W]ord w/args"})

      -- vim.keymap.set("n", "<leader>sn", "<cmd>Telescope notify<cr>", { desc = "[N]otifications" })

      local telescope = require("telescope")
      telescope.load_extension "fzf"
      telescope.load_extension "ui-select"
      telescope.load_extension "aerial"
      telescope.load_extension("live_grep_args")
      -- telescope.load_extension "notify"
      -- telescope.load_extension "frecency"
      -- telescope.load_extension "luasnip"
      -- telescope.load_extension "conventional_commits"
      -- telescope.load_extension "lazy"
    end,
  },
  {
    "stevearc/aerial.nvim",
    enabled = true,
    config = true,
  },
}

