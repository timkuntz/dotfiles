-- Ruby Tests
vim.keymap.set("n", "<leader>t", function()
  local current_file = vim.fn.expand("%")
  local current_line = vim.fn.line(".")
  -- local command = "terminal test_launcher " .. current_file .. ":" .. current_line
  -- local command = "vsplit term://test_launcher " .. current_file .. ":" .. current_line
  local command = "vsplit term://bundle exec rails test " .. current_file .. ":" .. current_line
  vim.cmd(command)
end, { desc = "Ruby Test", silent = true, buffer = 0 })

-- Automatically change to insert mode any time a terminal is opened
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("ruby-test-term-open", {}),
  pattern = { "*" },
  command = "startinsert",
})

-- Goto Test
local function get_relative_path()
    local current_file = vim.api.nvim_buf_get_name(0) -- Get the current buffer's full file path
    local project_root = vim.fn.getcwd() -- Get the current working directory (project root)

    -- You can customize the project_root logic to find the actual project root if needed
    -- For example, if you want to find the nearest .git directory:
    -- local project_root = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')

    -- Get the relative path by removing the project root from the current file path
    local relative_path = current_file:sub(#project_root + 2) -- +2 to remove the trailing separator

    return relative_path
end

local function test_path(relative_path)
    -- Replace "app" with "test"
    local modified_path = relative_path:gsub("/app/", "/test/")
    modified_path = relative_path:gsub("/lib/", "/test/")

    -- Append "_test" before the ".rb" extension
    modified_path = modified_path:gsub("(%.rb)$", "_test%1")

    return modified_path
end

local function file_exists(file_path)
    local stat = vim.loop.fs_stat(file_path)
    return stat ~= nil
end

vim.keymap.set("n", "gt", function()
  local relative_path = get_relative_path()
  local test_file = test_path(relative_path)
  if file_exists(test_file) then
    vim.cmd('edit ' .. test_file)
  else
    Snacks.notify.info("Test file not found: " .. test_file)
  end
end, { desc = "Goto Test", silent = true, buffer = 0 })
