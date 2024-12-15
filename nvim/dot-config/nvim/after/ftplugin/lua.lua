vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- run current file with plenary tests
vim.keymap.set("n", "<leader>t", function()
  vim.cmd("PlenaryBustedFile %")
end, { desc = "Lua Test", silent = true, buffer = 0 })

-- source the current file
vim.keymap.set("n", "<leader><leader>x", ":source %<CR>", { desc = "source file" })
-- write and source the current file
-- vim.keymap.set("n", "<leader><leader>x", ":w | source %<CR>", { desc = "save/source file" })
-- execute the current line in lua
vim.keymap.set("n", "<leader>x", ":.lua<cr>")
-- execute the selection in lua
vim.keymap.set("v", "<leader>x", ":lua<cr>")
