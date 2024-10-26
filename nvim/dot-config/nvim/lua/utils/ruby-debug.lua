-- modified from suketa/nvim-dap-ruby
-- allow for debugee to run externally
-- include additional launch configurations
local M = {}

local function load_module(module_name)
  local ok, module = pcall(require, module_name)
  assert(ok, string.format("dap-ruby dependency error: %s not installed", module_name))
  return module
end

local function splitAndAppend(str, array)
    for word in str:gmatch("%S+") do
        table.insert(array, word)
    end
end

local function setup_ruby_adapter(dap)
  dap.adapters.ruby = function(callback, config)
    local handle
    local stdout = vim.loop.new_pipe(false)
    local pid_or_err
    local waiting = config.waiting or 500
    local args
    local script
    local rdbg

    -- if we are attaching to an existing process, we don't need to start rdbg
    if config.command ~= "attach" then
      if config.current_line then
        script = config.script .. ":" .. vim.fn.line(".")
      else
        script = config.script
      end

      if config.bundle == "bundle" then
        args = { "-n", "--open", "--port", config.port, "-c", "--", "bundle", "exec" }
      else
        args = { "--open", "--port", config.port, "-c", "--" }
      end

      splitAndAppend(config.command, args)
      table.insert(args, script)

      local opts = {
        stdio = { nil, stdout },
        args = args,
        detached = false,
      }

      if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        rdbg = "rdbg.bat"
      else
        rdbg = "rdbg"
      end

      print("Starting rdbg: " .. rdbg .. " " .. table.concat(args, " "))
      handle, pid_or_err = vim.loop.spawn(rdbg, opts, function(code)
        handle:close()
        if code ~= 0 then
          assert(handle, "rdbg exited with code: " .. tostring(code))
          print("rdbg exited with code", code)
        end
      end)

      assert(handle, "Error running rdbg: " .. tostring(pid_or_err))
    end

    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)

    -- Wait for rdbg to start
    vim.defer_fn(function()
      callback({ type = "server", host = config.server, port = config.port })
    end, waiting)
  end
end

local function setup_ruby_configuration(dap)
  local default_config = {
    type = "ruby",
    request = "attach",
    port = 38698,
    server = "127.0.0.1",
    options = {
      source_filetype = "ruby",
    },
    localfs = true,
    waiting = 1000,
  }

  local launch_configs = {
    {
      name = "attach to existing process",
      command = "attach",
      script = "not_used",
    },
    {
      name = "rails",
      bundle = "bundle",
      command = "rails",
      script = "s",
    },
    {
      name = "rails test",
      command = "rails test",
      script = "${file}",
      waiting = 10000,
    },
    {
      name = "current file",
      bundle = "",
      command = "ruby",
      script = "${file}",
    },
    -- {
    --   name = "rspec current_file",
    --   bundle = "bundle",
    --   command = "rspec",
    --   script = "${file}",
    -- },
    -- {
    --   name = "rspec current_file:current_line",
    --   bundle = "bundle",
    --   command = "rspec",
    --   script = "${file}",
    --   current_line = true,
    -- },
    -- {
    --   name = "rspec",
    --   bundle = "bundle",
    --   command = "rspec",
    --   script = "./spec",
    -- },

  }

  dap.configurations.ruby = {}
  for _, launch_config in ipairs(launch_configs) do
    local config = require("utils").merge_tables(default_config, launch_config)
    table.insert(dap.configurations.ruby, config)
  end
end

function M.setup()
  local dap = load_module("dap")
  setup_ruby_adapter(dap)
  setup_ruby_configuration(dap)
end

return M
