local swap_next, swap_prev = (function()
	local swap_objects = {
		p = "@parameter.inner",
		f = "@function.outer",
		c = "@class.outer",
	}

	local n, p = {}, {}
	for key, obj in pairs(swap_objects) do
		n[string.format("<leader>cx%s", key)] = obj
		p[string.format("<leader>cX%s", key)] = obj
	end

	return n, p
end)()

-- local ruby_namespace = function()
NS = function()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local bufnr = vim.api.nvim_get_current_buf()
	local node = ts_utils.get_node_at_cursor()
	if node == nil then
		error("Unable to get node at cursor. Maybe no Treesitter parser found.")
	end
	-- initialize the namespace string we will return
	local ns = ""
	-- find the top of the current node's namespace
	while node ~= nil and node:type() ~= "program" do
		if node:type() == "class" or node:type() == "module" then
			local node_text = vim.treesitter.get_node_text(node, bufnr)
			local stripped_text = string.gsub(node_text, "^%s+", "")
			_, _, name = string.find(stripped_text, "^class (%a+)%s")
			if name ~= nil then
				ns = name
			end
			_, _, name = string.find(stripped_text, "^module (%a+)%s")
			if name ~= nil then
				ns = name .. "::" .. ns
			end
		end
		node = node:parent()
	end
	vim.fn.setreg("*", ns)
	return ns
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			sync_install = false,
			ensure_installed = {
				"bash",
				"dockerfile",
				"elixir",
				"graphql",
				"go",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"org",
				"query",
				"regex",
				"ruby",
				"sql",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = swap_next,
					swap_previous = swap_prev,
				},
			},
			matchup = {
				enable = true,
			},
			endwise = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

