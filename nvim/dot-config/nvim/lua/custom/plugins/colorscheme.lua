return {
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup {
        themes = {
          -- markdown = { colorscheme = "tokyonight" },
          -- help = { colorscheme = "tokyonight" },
        },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      lualine_bold = true,
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
      on_colors = function(colors)
        -- colors.bg = "#1a1b26" -- default
        -- colors.bg = "#000000"
      end,
      on_highlights = function(highlights, _)
        -- highlights.LineNr = { fg = "#3b4261" } -- default
        highlights.LineNr = { fg = "#6e7cb7" }
        -- highlights.LineNrAbove = "#3b4261"
        highlights.LineNrAbove = { fg = "#6e7cb7" }
        -- highlights. LineNrBelow =  "#3b4261"
        highlights. LineNrBelow = { fg =  "#6e7cb7" }
      end,
    },
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },
}

