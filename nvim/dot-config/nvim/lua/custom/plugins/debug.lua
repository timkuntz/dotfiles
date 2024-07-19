return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jbyuki/one-small-step-for-vimkind",
    -- because we define keymaps in config using which-key
    "folke/which-key.nvim",
  },
  enabled = true,
  config = function()
    require("nvim-dap-virtual-text").setup {
      commented = true,
    }

    local dap, dapui = require "dap", require "dapui"
    dap.set_log_level('TRACE')

    -- TODO: Extract this file to a nvim-dap-generic plugin
    --       removing the language specific bits
    --       this file will reference the generic plugin
    --       and add the language specific bits back
    -- require("pde.debug.ruby").setup()

    -- lua debug setup (extract to separate file)
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
      }
    }

    dap.adapters.nlua = function(callback, config)
      callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
    -- lua require"osv".launch({port = 8086})
    -- end lua

    dapui.setup {
      layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "repl",
            size = 1.0
          -- }, {
          --   id = "console",
          --   size = 0.5
          } },
        position = "bottom",
        size = 10
      } },
    } -- use default
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    local keymap = {
      d = {
        name = "+Debug",
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        a = { "<cmd>lua require'dap'.restart()<cr>", "Restart" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        d = { "<cmd>lua require'dap'.focus_frame()<cr>", "Focus current frame" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        j = { "<cmd>lua require'dap'.up()<cr>", "Go up the stack frame" },
        k = { "<cmd>lua require'dap'.down()<cr>", "Go down the stack frame" },
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        X = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints" },
        -- f = { "<cmd>Telescope dap frames<cr>", "Telescope frames" },
        -- b = { "<cmd>Telescope dap list_breakpoints<cr>", "Telescope list breakpoints" },
        -- v = { "<cmd>lua require'telescope'.extensions.dap.variables{}<cr>", "Toggle Repl" },
        r = { "<cmd>lua  require('dapui').float_element('repl', { width = 100, height = 20, enter = true, position = 'center' })<cr>", "Toggle Repl" },
        w = { "<cmd>lua  require('dapui').float_element('watches', { width = 100, height = 20, enter = true, position = 'bottom' })<cr>", "Toggle Watch" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      },
    }
    require("utils").register_keys(keymap)
  end,
}
