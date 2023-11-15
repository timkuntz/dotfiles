local indent = 2

-- controls automated forrmatting such as wrapping
vim.o.formatoptions = "jcroqlnt"
-- controls what abbreviated text is used
vim.o.shortmess = "filnxtToOFWIcC"
-- wrapped lines are visually indented
vim.opt.breakindent = true
-- number of lines for command-line; 0 means hide
vim.opt.cmdheight = 1
-- 'unnamed' sends yanks to system clipboard
vim.opt.clipboard = "unnamed"
-- options for how completion popups behave
-- show menu when 1 option; force user to select
vim.opt.completeopt = "menuone,noselect"
-- text with 'conceal' syntax attribute is hidden
vim.opt.conceallevel = 3
-- show a dialog to confirm operations such as :qall
vim.opt.confirm = true
-- highlight line that cursor is on
vim.opt.cursorline = true
-- convert tab to spaces
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.joinspaces = false
vim.opt.laststatus = 0
vim.opt.list = true
-- Enable mouse mode
vim.opt.mouse = "a"
-- show line numbers
vim.opt.number = true
-- popup-menu opaque = 0 to transparent = 30
vim.opt.pumblend = 10
-- popmenu max lines to show
vim.opt.pumheight = 10
-- show relative line numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
-- can be set with :let &statuscolumn='%=%l%s%C'
-- using the default value or delegating to a plugin
-- vim.opt.statuscolumn=""
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.wildmode = "longest:full,full"

vim.opt.foldlevel = 20
-- how to display the fold column
-- vim.opt.foldcolumn = "auto"
vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- providers
vim.g.loaded_perl_provider = 0

-- set leader to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

