local M = {}

local function default_on_open(term)
  vim.cmd "stopinsert"
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

function M.open_term(cmd, opts)
  opts = opts or {}
  opts.size = opts.size or vim.o.columns * 0.5
  opts.direction = opts.direction or "float"
  opts.on_open = opts.on_open or default_on_open
  opts.on_exit = opts.on_exit or nil

  local Terminal = require("toggleterm.terminal").Terminal
  local new_term = Terminal:new {
    cmd = cmd,
    dir = "git_dir",
    auto_scroll = false,
    close_on_exit = false,
    start_in_insert = false,
    on_open = opts.on_open,
    on_exit = opts.on_exit,
  }
  new_term:open(opts.size, opts.direction)
end

function M.reload_module(name)
  require("plenary.reload").reload_module(name)
end

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.fold_methods()
  local api = vim.api
  local ts_utils = require('nvim-treesitter.ts_utils')
  local bufnr = api.nvim_get_current_buf()
  local lang = api.nvim_buf_get_option(bufnr, 'ft')
  local root = ts_utils.get_root_for_bufnr(bufnr)
  local method_nodes = ts_utils.get_named_children(root, lang, 'method_declaration')

  for _, node in ipairs(method_nodes) do
    local start_row, _, _, end_row = node:range()
    api.nvim_buf_set_foldlevel(bufnr, start_row - 1, 1)
    api.nvim_buf_add_fold(bufnr, start_row - 1, end_row)
  end
end

function M.merge_tables(defaults, custom)
    local newTable = {}
    for key, value in pairs(defaults) do
        newTable[key] = value
    end
    for key, value in pairs(custom) do
        newTable[key] = value
    end
    return newTable
end

return M

