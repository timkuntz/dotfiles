M = {}

M.prefer_current_tab = 1
M.current_tab_only = 1

M.get_current_tab = function()
  local current_window_id = vim.api.nvim_get_current_win()
  return vim.fn.win_id2tabwin(current_window_id)[1] -- 1 is the first element
end

M.find_window_in_tab = function(windows, current_tabnr)
  for _, window in ipairs(windows) do
    if M.current_tabl_only == 1 then
      if vim.fn.win_id2tabwin(window)[1] == current_tabnr then
        return window
      end
    end
  end
  return -1
end

M.get_listed_buffers = function(buffers)
  local listed = {}
  for _, buffer in ipairs(buffers) do
    if buffer.listed == 1 then
      table.insert(listed, buffer)
    end
  end
  return listed
end

M.get_previous_buffer_index = function(buffers)
  local bufnr = vim.api.nvim_get_current_buf()

  local i = #buffers
  while buffers[i] do
    if buffers[i].bufnr < bufnr then return i end
    i = i - 1
  end
  return #buffers
end

M.get_next_buffer_index = function(buffers)
  local bufnr = vim.api.nvim_get_current_buf()

  for i, buffer in ipairs(buffers) do
    if buffer.bufnr > bufnr then return i end
  end
  return 1
end

M.goto_previous_buffer = function()
  local buffers = M.get_listed_buffers(vim.fn.getbufinfo())
  local index = M.get_previous_buffer_index(buffers)

  local target_window = M.find_window_in_tab(buffers[index].windows, M.get_current_tab())
  if target_window > -1 then
    vim.fn.win_gotoid(target_window)
  else
    vim.cmd "bp"
  end
end

M.goto_next_buffer = function()
  local buffers = M.get_listed_buffers(vim.fn.getbufinfo())
  local index = M.get_next_buffer_index(buffers)

  -- TODO - rethink whether we should restrict to current tab
  --        maybe make a configuration option?
  local target_window = M.find_window_in_tab(buffers[index].windows, M.get_current_tab())
  if target_window > -1 then
    vim.fn.win_gotoid(target_window)
  else
    vim.cmd "bn"
  end
end

M.only_buffer = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buffers = M.get_listed_buffers(vim.fn.getbufinfo())

  for _, buffer in ipairs(buffers) do
    if buffer.bufnr ~= bufnr and buffer.changed == 0 then
      vim.cmd('bd' .. ' ' .. buffer.bufnr)
    end
  end
end

return M


