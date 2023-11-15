-- https://github.com/ThePrimeagen/git-worktree.nvim
return {
  'ThePrimeagen/git-worktree.nvim',
  enabled = config.pde.git_worktree,
  init = function()
    require("git-worktree").setup({
      change_directory_command = "cd", -- default: "cd",
        update_on_change = true, -- default: true,
        update_on_change_command = "e .", -- default: "e .",
        clearjumps_on_change = true, -- default: true,
        autopush = false, -- default: false,
    })
    require("telescope").load_extension('git_worktree')

    local Worktree = require("git-worktree")
    -- op = Operations.Switch, Operations.Create, Operations.Delete
    -- metadata = table of useful values (structure dependent on op)
    --      Switch
    --          path = path you switched to
    --          prev_path = previous worktree path
    --      Create
    --          path = path where worktree created
    --          branch = branch name
    --          upstream = upstream remote name
    --      Delete
    --          path = path where worktree deleted
    --
    local create = function()
      local name = vim.fn.getcwd():match("^.+/(.+)$")
      require("workspaces").open(name)
    end

    -- TODO the session switching needs to be improved
    --      it should not keep files open from the old session
    local switch = function()
      -- TODO make this a function in the start-screen plugin that is callable from here
      local session_dir = vim.fn.stdpath("data") .. '/' .. 'sessions' .. '/'
      local session_name = vim.fn.getcwd():match("^.+/(.+)$")
      local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
      if branch ~= "" then
        session_name = session_name .. '-' .. branch
      end
      local session_path = session_dir .. session_name
      -- if session exists load, else save (create)
      local f=io.open(session_path,"r")
      if f~=nil then
        io.close(f)
        require("sessions").load(session_path, { silent = true })
        P('Loaded session: ' .. session_path)
      else
        require("sessions").save(session_path, { silent = true })
        P('Created session: ' .. session_path)
      end
    end

    local delete = function()
      -- not implemented
    end

    Worktree.on_tree_change(function(op, metadata)
      ops = {
        [Worktree.Operations.Switch] = switch,
        [Worktree.Operations.Create] = create,
        [Worktree.Operations.Delete] = delete,
      }
      ops[op]()
    end)
  end,
  keys = {
    { "<leader>g", "", desc = "Git" },
    { "<leader>gs", function() require('telescope').extensions.git_worktree.git_worktrees() end, desc = "Worktrees switch" },
    { "<leader>gc", function() require('telescope').extensions.git_worktree.create_git_worktree() end, desc = "Worktrees create" },
  },
}
