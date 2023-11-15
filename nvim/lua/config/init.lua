config_home = vim.fn.stdpath("config")
nv_config = os.getenv("NV_CONFIG")

-- default setup
config = {}
config.base = {}
config.base.active = true
config.base.lualine = {}
config.base.lualine.active = true

-- wiki setup
config.wiki = {}
config.wiki.base = false
if nv_config == "wiki" then
  config.wiki.base = true
end

-- pde setup
is_pde = nv_config == "pde"
config.pde = {}
config.pde.copilot = is_pde
config.pde.git = is_pde
config.pde.git_worktree = is_pde
config.pde.harpoon = is_pde
config.pde.nvim_surround = is_pde

-- print(vim.inspect(config))
