local buffers = require("utils.buffers")

local keymap = vim.keymap.set
local defaults = { noremap = true, silent = true }

local defs = function(opts)
  local new_opts = {}
  for k,v in pairs(defaults) do new_opts[k] = v end
  for k,v in pairs(opts) do new_opts[k] = v end
  return new_opts
end

-- move up/down .5 page and center cursor
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", defaults)
keymap("i", "jj", "<ESC>", defaults)
keymap("i", "WW", "<ESC>:w<CR>", defaults)

-- While in terminal mode
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Navigate vim panes better
keymap("n", "<c-k>", ":wincmd k<CR>", { noremap = false, silent = true })
keymap("n", "<c-j>", ":wincmd j<CR>", { noremap = false, silent = true })
keymap("n", "<c-h>", ":wincmd h<CR>", { noremap = false, silent = true })
keymap("n", "<c-l>", ":wincmd l<CR>", { noremap = false, silent = true })

-- Copy/Paste
keymap("n", "yp", ':let @*=expand("%")<CR>', defaults)
keymap("n", "yP", ':let @*=expand("%:p")<CR>', defaults)

-- Yank entire file content
keymap("n", "yY", ":%y+<CR>", defaults)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', defaults)

-- quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", defs({ desc = "quit" }))

-- restore the session for the current directory
keymap("n", "<leader>qr", [[<cmd>lua require("persistence").load()<cr>]], defs({ desc = "restore session" }))
keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr><cmd>qa<cr>]], defs({ desc = "quit w/o session" }))

-- don't do this, it creates issues for typing
-- vim.keymap.set('i', 'mw', '<ESC>:w<CR>', { desc = 'Write buffer' })

-- TODO remove any mappings below that wouldn't be part of a base install
--      they shouldn't require installing anything but Neovim

-- set appfolio test_launcher
-- keymap("n", "mtl", ":let test#ruby#rails#executable = 'test_launcher'<CR>", defaults)

-- additional telescope mappings
-- see init.lua for mappings setup as part of kickstarter
-- keymap("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[b]uffers" })

-- Rails.vim Alt file
keymap("n", "mA", ":A<CR>", defaults)

-- run a neovim plugin test file
-- keymap("n", "<leader>Tp", "<Plug>PlenaryTestFile<CR>", { desc = "Test Plugin" })

-- ruby: insert pry debug below cursor
-- keymap("n", "<leader>rP", 'orequire "pry";binding.pry<ESC>', { desc = "Insert Pry" })

-- use tab to cycle through buffers
keymap("n", "<TAB>", buffers.goto_next_buffer, defaults)
-- vim.keymap.set('n', '<TAB>', ':bn<CR>', defaults)

-- use tshift+tab to cycle through tabs
keymap("n", "<S-TAB>", buffers.goto_previous_buffer, defaults)
-- vim.keymap.set('n', '<S-TAB>', ':bp<CR>', defaults)

-- close the current buffer
--- @diagnostic disable-next-line: undefined-global
keymap("n", "<leader>bd", function() Snacks.bufdelete() end, {desc = "Delete current" })
-- close all other buffers
--- @diagnostic disable-next-line: undefined-global
keymap("n", "<leader>bo", Snacks.bufdelete.other, {desc = "Delete others" })
-- close all buffers
--- @diagnostic disable-next-line: undefined-global
keymap("n", "<leader>ba", Snacks.bufdelete.all, {desc = "Delete all" })
-- close all but harpoon listed items
keymap("n", "<leader>bh", buffers.harpoon_only, { desc = "Keep harpoon only" })

-- source the current file
keymap("n", "<leader>x", ":source %<CR>")
-- write and source the current file
keymap("n", "<leader><leader>x", ":w | source %<CR>")

-- TODO NS is a custom function in for treesitter
keymap("n", "<Leader>cy", NS, { noremap = true, silent = true, desc = "Yank FQ class" })

-- goto tab #
keymap("n", "<M-1>", ":tabnext 1<CR>", defaults)
keymap("n", "<M-2>", ":tabnext 2<CR>", defaults)
keymap("n", "<M-3>", ":tabnext 3<CR>", defaults)
keymap("n", "<M-4>", ":tabnext 4<CR>", defaults)
keymap("n", "<M-5>", ":tabnext 5<CR>", defaults)

-- format sql
-- requires `brew install pgformatter`
keymap("n", "<Leader>fs", ":%!pg_format<CR>", defaults)
keymap("v", "<Leader>fs", ":'<,'>!pg_format<CR>", defaults)

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +2<CR>", defaults)
keymap("n", "<Right>", ":vertical resize -2<CR>", defaults)
keymap("n", "<Up>", ":resize -2<CR>", defaults)
keymap("n", "<Down>", ":resize +2<CR>", defaults)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Navigate the quickfix list
keymap("n", "]q", "<cmd>cnext<CR>", { desc = "Forward qfixlist" })
keymap("n", "[q", "<cmd>cprev<CR>", { desc = "Backward qfixlist" })
-- Navigate quickfix lists
keymap("n", "]Q", "<cmd>colder<CR>", { desc = "Older qfixlist" })
keymap("n", "[Q", "<cmd>cnewer<CR>", { desc = "Newer qfixlist" })


-- Call system open with the contents of the default register
keymap("n", '<leader>o', [[<CMD>lua vim.fn.system("open " .. vim.fn.getreg('"'))<CR>]], { noremap = true, silent = true, desc = "Open Register"})

local groups = {
  mode = { "n", "v" },
  { "<leader>b", group = "+Buffer" },
  { "<leader>c", group = "Code" },
  { "<leader>e", group = "+Explore" },
  { "<leader>g", group = "+Git" },
  { "<leader>h", group = "+Help" },
  { "<leader>s", group = "+Search" },
  { "<leader>u", group = "+UI" },
}
require("which-key").add(groups)


