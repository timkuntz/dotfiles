vim.keymap.set('n', '<CR>', function()
  local line = vim.fn.getline('.')
  local match = line:match('%* %[.-%]%((.-)%)')
  if match then
    vim.cmd('edit ' .. match)
  end
end, { buffer = 0 })
