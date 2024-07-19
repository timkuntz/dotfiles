-- Ruby Tests
vim.keymap.set("n", "<leader>t", function()
  local current_file = vim.fn.expand("%")
  local current_line = vim.fn.line(".")
  -- local command = "terminal test_launcher " .. current_file .. ":" .. current_line
  local command = "vsplit term://test_launcher " .. current_file .. ":" .. current_line
  vim.cmd(command)
end, { desc = "Ruby Test", silent = true, buffer = 0 })

-- Automatically change to insert mode any time a terminal is opened
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("ruby-test-term-open", {}),
  pattern = { "*" },
  command = "startinsert",
})

