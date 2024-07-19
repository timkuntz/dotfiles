-- WIP nothing useful here yet
local m = {}

m.test_setup_quickfix = function()
  vim.o.errorformat=[[%.%#[%f:%l]:]]
  -- open the quickfix window
  vim.cmd([[copen]])
  -- clear the contents of the quickfix buffer
  vim.fn.setqflist({}, 'r')
  -- return the buffer number of the quickfix
  return vim.fn.getqflist({['qfbufnr'] = 0}).qfbufnr
end

m.test_run = function()
  m.test_setup_quickfix()
  vim.fn.jobstart({'test_launcher', 'test/unit/jobs/insurance/billing_job_test.rb'}, {
    stdout_buffered = false,
    on_stdout = function(_, data, _)
      if data then
        P(data)
        vim.fn.setqflist(data, 'a')
        -- vim.api.nvim_buf_set_lines(bufrnr, -1, -1, false, data)
      end
    end,
    on_stderr = function(_, data, _)
      vim.fn.setqflist({data}, 'a')
      -- vim.api.nvim_buf_set_lines(bufrnr, -1, -1, false, data)
    end,
    on_exit = function(_, _, _)
      vim.fn.setqflist({'done'}, 'a')
      -- vim.api.nvim_buf_set_lines(bufrnr, -1, -1, false, {'done'})
    end,
  })
end

m.test_autosave = function()
  local bufrnr = 14
  -- vim.api.nvim_buf_set_lines(bufrnr, 0, -1, false, {'hello', 'world'})
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('test-autosave', { clear = true }),
    pattern = 'test/unit/jobs/insurance/billing_job_test.rb',
    callback = m.test_run,
  })
end

return m
