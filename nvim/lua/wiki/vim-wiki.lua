return {
	"vimwiki/vimwiki",
	enabled = config.wiki.base,
	event = "VeryLazy",
	init = function()
		vim.g.vimwiki_list = {
			{
				path = "~/Dropbox/notes/",
				path_html = "~/Downloads/wiki_html/",
				diary_frequency = "weekly",
				auto_diary_index = 1,
				auto_generate_tags = 1,
				vimwiki_auto_header = 1,
				syntax = "markdown",
				ext = ".md",
			},
			{
				path = "~/Dropbox/notebook/",
				path_html = "~/Downloads/notebook_html/",
				diary_frequency = "weekly",
				auto_diary_index = 1,
				auto_generate_tags = 1,
				vimwiki_auto_header = 1,
			},
		}

		vim.keymap.set("n", "<leader>wg", ":VimwikiRebuildTags<CR>", { desc = "Generate Tags" })
	end,
}

