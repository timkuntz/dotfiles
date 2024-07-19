-- https://docs.github.com/en/copilot/getting-started-with-github-copilot?tool=vimneovim
-- https://github.com/github/copilot.vim/tree/release

-- first call to this function doesn't seem to work
local copilot_accept = function()
	vim.g.copilot_no_tab_map = true
	vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept()', { script = true, nowait = true, silent = true, expr = true })
end

return {
	'github/copilot.vim',
	lazy = false,
	enabled = false,
  keys = {
    { "<leader>cC", "", desc = "Copilot" },
    { "<leader>cCs", "<CMD>Copilot status<CR>", desc = "status" },
    { "<leader>cCe", "<CMD>Copilot enable<CR>", desc = "enable" },
    { "<leader>cCd", "<CMD>Copilot disable<CR>", desc = "disable" },
    { "<C-j>", copilot_accept, mode = "i", desc = "Copilot accept" },
  },
}
