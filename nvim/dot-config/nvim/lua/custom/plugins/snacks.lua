--- @diagnostic disable: undefined-global

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = true }, -- see keymaps.lua and buffers.lua for usage
    dashboard = {
      enabled = false,
      example = "files", -- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#-examples
    },
    debug = { enabled = true },
    dim = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    notify = { enabled = true },
    quickfile = { enabled = true },
    scratch = {
      enabled = true,
      win = {
        keys = {
          ["execute"] = {
            "<cr>",
            function(_)
              vim.cmd("%SnipRun")
            end,
            desc = "Execute buffer",
            mode = { "n", "x" },
          },
        },
      },
      win_by_ft = {
        lua = {
          keys = {
            ["source"] = {
              "<cr>",
              function(self)
                local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                Snacks.debug.run({ buf = self.buf, name = name })
              end,
              desc = "Source buffer",
              mode = { "n", "x" },
            },
          },
        },
      },
    },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    },
    terminal = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = false },
    zen = { enabled = true },
  },
  keys = {
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

    { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.option("hlsearch", { name = "Highlight" }):map("<leader>uh")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uH")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
