-- Fuzzy Finder (files, lsp, etc)
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = false,
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
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

      local limit_to_search_paths = true

      -- See `:help telescope.builtin`
      local find_files = function()
        local function file_exists(path)
          local stat = vim.loop.fs_stat(path)
          return stat and stat.type == 'file' -- Returns true if the file exists
        end

        -- Function to read file paths from a specified file into a table
        local function read_file_paths(filename)
          local paths = {}  -- Table to hold the file paths

          -- Open the file for reading
          local file = io.open(filename, "r")
          if not file then
            print("Could not open file: " .. filename)
            return nil  -- Return nil if the file cannot be opened
          end

          -- Read each line and insert it into the table
          for line in file:lines() do
            if line and line ~= "" then  -- Check if the line is not empty
              table.insert(paths, line)
            end
          end

          file:close()  -- Close the file after reading
          return paths  -- Return the table containing file paths
        end

        local search_paths = ".fd-priority"

        -- Conditional statement
        if limit_to_search_paths and file_exists(search_paths) then
          local file_paths = read_file_paths(search_paths)
          require("telescope.builtin").find_files({
            hidden = true,
            search_dirs = file_paths,
          })
        else
          require("telescope.builtin").find_files({
            hidden = true,
          })
        end
      end

      require("telescope").setup({
        defaults = {
          mappings = mappings,
        },
        pickers = {
          find_files = {
            mappings = {
              i = {
                ["<C-g>"] = function()
                  limit_to_search_paths = not limit_to_search_paths
                  find_files()
                end
              }
            }
          }
        },
        extensions = {
          live_grep_args = {
            auto_quoting = false, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                -- ["<C-u>"] = lga_actions.quote_prompt(),
                -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob !**test** " }),
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-f>"] = actions.to_fuzzy_refine,
              },
            },
          }
        },
      })

      vim.keymap.set("n", "<leader>sf", function()
        limit_to_search_paths = true
        find_files()
      end, { desc = "[f]iles" })

      vim.keymap.set("n", "<leader>sF", function()
        require("telescope.builtin").find_files({
          hidden = true,
        })
      end, { desc = "All [f]iles" })

      vim.keymap.set("n", "<leader>sv", function()
        require("telescope.builtin").find_files({cwd = vim.fn.stdpath('config')})
      end, { desc = "[v]im" })

      vim.keymap.set("n", "<leader>sn", function()
        require("telescope.builtin").find_files({cwd = '~/Library/CloudStorage/Dropbox/notes'})
      end, { desc = "[n]otes" })

      -- requires the executable 'rg'; brew install rg
      vim.keymap.set("n", "<leader>sg", function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end, { desc = "[g]rep" })

      vim.keymap.set("n", "<leader>sG", function()
        require("custom.telescope.multigrep").live_multigrep({
          hidden = true,
        })
      end, { desc = "Multi [G]rep" })

      local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
      vim.keymap.set("n", "<leader>sw", function()
        lga_shortcuts.grep_word_under_cursor({quote = false, postfix = " -F --iglob !**test** "})
      end, { desc = "current [w]ord w/args"})

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

      local telescope = require("telescope")
      telescope.load_extension "fzf"
      telescope.load_extension "ui-select"
      telescope.load_extension "aerial"
      telescope.load_extension("live_grep_args")
    end,
  },
  -- {
  --   "stevearc/aerial.nvim",
  --   enabled = false,
  --   config = true,
  -- },
}

