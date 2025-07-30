--
-- copied from LazyVim
--
local function augroup(name)
  return vim.api.nvim_create_augroup("quigkin_" .. name, { clear = true })
end

--
-- Let's stop manually saving
--
-- TODO make sure the buffer exists so it doesn't break the world
-- vim.api.nvim_create_autocmd({'FocusLost', 'BufLeave'}, {
--   group = augroup("focus_lost"),
--   callback = function(_)
--     vim.cmd.stopinsert()
--     vim.cmd.wall { mods = { silent = true } }
--   end,
-- })
--
-- -- Check if we need to reload the file when it changed
-- vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
--   group = augroup("checktime"),
--   command = "checktime",
-- })
--
-- -- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
--
-- -- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- -- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- -- Auto create dir when saving a file, in case some intermediate directory does not exist
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = augroup("auto_create_dir"),
--   callback = function(event)
--     if event.match:match("^%w%w+://") then
--       return
--     end
--     local file = vim.loop.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })

-- this loads the session but syntax highlighting is not working
-- Define an autocommand to load the session on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
  callback = function()
    -- Don't load the session if Neovim was started with arguments
    if vim.fn.argc() == 0 then
      require("persistence").load()
    end
  end,
  nested = true,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.es6",
    callback = function()
        vim.opt.filetype = "javascript"
    end,
})

