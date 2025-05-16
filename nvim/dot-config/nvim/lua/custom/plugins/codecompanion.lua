local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "copilot",
        slash_commands = {
          ["buffer"] = {
            keymaps = {
              modes = {
                i = "<C-b>",
                n = { "<C-b>", "gb" },
              },
            },
          },
          ["file"] = {
            keymaps = {
              modes = {
                i = "<C-f>",
                n = { "<C-f>", "gf" },
              },
            },
          },
        },
      },
      inline = {
        adapter = "copilot",
      },
    },
    prompt_library = {
      ["Fix Test workflow"] = {
        strategy = "workflow",
        description = "Use a workflow to repeatedly test then edit code",
        opts = {
          index = 5,
          is_default = true,
          short_name = "ft",
        },
        prompts = {
          {
            {
              name = "Setup Test",
              role = constants.USER_ROLE,
              opts = { auto_submit = false },
              content = function()
                -- Enable turbo mode!!!
                vim.g.codecompanion_auto_tool_mode = true

                return [[### Instructions

1. Run the test in the provided context using the @cmd_runner tool to run `<test_command>`.
2. If the test is successful, print a 'Success!' message and stop here.
3. If the test fails, identify the correct files(s) to edit, open, and edit with the @editor tool.
4. Make sure you trigger both tools in the same response
5. Repeat the process until the test passes.

We'll repeat this cycle until the tests pass. Ensure no deviations from these steps.]]
              end,
            },
          },
          {
            {
              name = "Repeat On Failure",
              role = constants.USER_ROLE,
              opts = { auto_submit = true },
              -- Scope this prompt to the cmd_runner tool
              condition = function()
                return _G.codecompanion_current_tool == "cmd_runner"
              end,
              -- Repeat until the tests pass, as indicated by the testing flag
              -- which the cmd_runner tool sets on the chat buffer
              repeat_until = function(chat)
                return chat.tools.flags.testing == true
              end,
              content = "The tests have failed. Can you edit the buffer and run the test suite again?",
            },
          },
        },
      },
    } -- end prompt_library
  }, --end opts
  init = function()
    require("custom.plugins.codecompanion.fidget-spinner"):init()

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Actions" })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "CodeCompanion Chat" })
  end,
}
