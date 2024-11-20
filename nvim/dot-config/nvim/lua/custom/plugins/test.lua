return {
	{
		"vim-test/vim-test",
		dependencies = {
			"tpope/vim-dispatch",
		},
		enabled = true,
		keys = {
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test Suite" },
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File" },
			{ "<leader>tc", "<cmd>w|TestClass<cr>", desc = "Class" },
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test Nearest" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last" },
			{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test Visit" },
			-- TODO find single key mapping that cycles through failures
			{ "<leader>tN", "<cmd>cn<cr>", desc = "Next Failure" },
			{ "<leader>tP", "<cmd>cp<cr>", desc = "Previous Failure" },
		},
		config = function()
			-- TODO display success / failure notifications in test buffer
			--      include the expected / actual information as well

			vim.g["test#strategy"] = "dispatch"

			-- vim.g["test#ruby#minitest#executable"] = "test_launcher"
			-- vim.g["test#ruby#minitest#options"] = "--verbose"

			-- vim.g["test#ruby#rails#executable"] = "test_launcher"
			-- vim.g["test#ruby#rails#options"] = "--verbose"
			-- vim.g["test#neovim#term_position"] = "belowright"
			vim.g["test#neovim#preserve_screen"] = 0

			vim.g["test#neovim#position"] = "horizontal"

			-- https://flukus.github.io/vim-errorformat-demystified.html
			-- https://neovim.io/doc/user/quickfix.html#errorformat
			-- set the error format to match the output of test_launcher
			-- this way we can use navigation in the quickfix window
			-- || Jobs::Insurance::BillingJobTest#test_perform__hides_insurance_billings_when_move_in_is_changed_to_after_billing_cycle [/Users/tim.kuntz/src/apm_bundle/apps/property/test/unit/jobs/insurance/billing_job_test.rb:148]:
			-- this will convert just the error line and leave the rest of the output
			-- vim.o.errorformat=[[%.%#[%f:%l]:]]

			-- adding the additional %-G will remove all non-matching content
			-- but we don't want to do that
			-- vim.o.errorformat=[[%.%#\ [%f:%l]:,%-G%.%#]]

			-- not sure what the correct format for setting the compilers is
			-- but likely not needed
			-- vim.g.dispatch_compilers = {
			-- 	["test_launcher"] = "",
			-- 	["ruby"] = "",
			-- 	["rails"] = "",
			-- }
			-- vim.g.dispatch_compilers["ruby"] = "rake"
			-- vim.g.dispatch_compilers["bundle exec"] = ""
		end,
	},
	-- TODO review this again and see if it covers the issues above
	{
		"nvim-neotest/neotest",
		enabled = false,
		keys = {
			{
				"<leader>TNF",
				"<cmd>w|lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
				desc = "Debug File",
			},
			{
				"<leader>TNL",
				"<cmd>w|lua require('neotest').run.run_last({strategy = 'dap'})<cr>",
				desc = "Debug Last",
			},
			{ "<leader>TNa", "<cmd>w|lua require('neotest').run.attach()<cr>", desc = "Attach" },
			{ "<leader>TNf", "<cmd>w|lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "File" },
			{ "<leader>TNl", "<cmd>w|lua require('neotest').run.run_last()<cr>", desc = "Last" },
			{ "<leader>TNn", "<cmd>w|lua require('neotest').run.run()<cr>", desc = "Nearest" },
			{ "<leader>TNN", "<cmd>w|lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
			{ "<leader>TNo", "<cmd>w|lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
			{ "<leader>TNs", "<cmd>w|lua require('neotest').run.stop()<cr>", desc = "Stop" },
			{ "<leader>TNS", "<cmd>w|lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
			"zidhuss/neotest-minitest",
		},
		config = function()
			-- vim.g["test#strategy"] = "dispatch"
			-- vim.g["test#strategy"] = "integrated"

			require("neotest").setup({
				adapters = {
					-- require("neotest-minitest"),
					-- require("neotest-plenary"),
					require("neotest-vim-test")({
						ignore_file_types = { "python", "vim", "lua" },
					}),
				},
				-- overseer.nvim
				-- consumers = {
				-- 	overseer = require("neotest.consumers.overseer"),
				-- },
				-- overseer = {
				-- 	enabled = true,
				-- 	force_default = true,
				-- },
			})
		end,
	},
	{
		"stevearc/overseer.nvim",
		enabled = false,
		keys = {
			{ "<leader>ToR", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
			{ "<leader>Toa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
			{ "<leader>Tob", "<cmd>OverseerBuild<cr>", desc = "Build" },
			{ "<leader>Toc", "<cmd>OverseerClose<cr>", desc = "Close" },
			{ "<leader>Tod", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
			{ "<leader>Tol", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
			{ "<leader>Too", "<cmd>OverseerOpen<cr>", desc = "Open" },
			{ "<leader>Toq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
			{ "<leader>Tor", "<cmd>OverseerRun<cr>", desc = "Run" },
			{ "<leader>Tos", "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
			{ "<leader>Tot", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
		},
		config = true,
	},
	-- {
	--   "andythigpen/nvim-coverage",
	--   cmd = { "Coverage" },
	--   config = true,
	-- },
}

