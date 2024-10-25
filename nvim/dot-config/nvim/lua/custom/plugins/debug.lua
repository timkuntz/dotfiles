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
  enabled = false,
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
      { "<leader>d", group = "Debug", nowait = false, remap = false },
      { "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint", nowait = false, remap = false },
      { "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI", nowait = false, remap = false },
      { "<leader>dX", "<cmd>lua require'dap'.clear_breakpoints()<cr>", desc = "Clear breakpoints", nowait = false, remap = false },
      { "<leader>da", "<cmd>lua require'dap'.restart()<cr>", desc = "Restart", nowait = false, remap = false },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = false, remap = false },
      { "<leader>dd", "<cmd>lua require'dap'.focus_frame()<cr>", desc = "Focus current frame", nowait = false, remap = false },
      { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Evaluate", nowait = false, remap = false },
      { "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Hover Variables", nowait = false, remap = false },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = false, remap = false },
      { "<leader>dj", "<cmd>lua require'dap'.up()<cr>", desc = "Go up the stack frame", nowait = false, remap = false },
      { "<leader>dk", "<cmd>lua require'dap'.down()<cr>", desc = "Go down the stack frame", nowait = false, remap = false },
      { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = false, remap = false },
      { "<leader>dr", "<cmd>lua require('dapui').float_element('repl', { width = 100, height = 20, enter = true, position = 'center' })<cr>", desc = "Toggle Repl", nowait = false, remap = false },
      { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = false, remap = false },
      { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = false, remap = false },
      { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = false, remap = false },
      { "<leader>dw", "<cmd>lua require('dapui').float_element('watches', { width = 100, height = 20, enter = true, position = 'bottom' })<cr>", desc = "Toggle Watch", nowait = false, remap = false },
      { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate", nowait = false, remap = false },
    }
    require("which-key").add(keymap)
  end,
}
