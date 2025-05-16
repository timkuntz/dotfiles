return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a5bf" })
    require("copilot").setup({
      copilot_node_command = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/22.14.0/bin/node",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-j>",
          accept_word = false,
          accept_line = false,
          next = "<C-l>",
          prev = "<C-h>",
          dismiss = "<C-]>",
        },
      }
    })
  end,
}

