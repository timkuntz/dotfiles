-- First things first
vim.g.mapleader = " "
vim.g.maplocalleader = ","

--- Install lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    { import = "custom/plugins" },
  },
  defaults = { lazy = false, version = nil },
  install = { missing = true, colorscheme = { "tokyonight" } },
  checker = { enabled = true, notify = true },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })
