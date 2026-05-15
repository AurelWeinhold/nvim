-- focus on the preview window to search/copy in there
-- https://github.com/nvim-telescope/telescope.nvim/issues/2778#issuecomment-2202572413
local function focus_preview(prompt_bufnr)
	local action_state = require("telescope.actions.state")
	local picker = action_state.get_current_picker(prompt_bufnr)
	local prompt_win = picker.prompt_win
	local previewer = picker.previewer
	local bufnr = previewer.state.bufnr or previewer.state.termopen_bufnr
	local winid = previewer.state.winid or vim.fn.win_findbuf(bufnr)[1]

	-- keymap for switching back
	vim.keymap.set("n", "<C-l>", function()
		vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
	end, { buffer = bufnr })
	vim.keymap.set("n", "<C-h>", function()
		vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
	end, { buffer = bufnr })
	vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
	-- api.nvim_set_current_win(winid)
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
		},
	},
	config = function()

		require('telescope').setup{
			defaults = {
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
						["<C-h>"] = focus_preview,
						["<C-l>"] = focus_preview,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"rg", "--files",
						"--hidden",
						"--follow",
						"--iglob", "!.git/*",
						"--iglob", "!.git",
						"--iglob", "!.venv",
					},
				}
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				}
			}
		}

		-- extensions
		require('telescope').load_extension('fzf')

		-- mappings
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>f', builtin.find_files, {})
		vim.keymap.set('n', '<leader>t', builtin.tags, {})
		vim.keymap.set('n', '<leader>ft', builtin.current_buffer_tags, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, {})
		-- replace default z= with a telescope picker
		vim.keymap.set('n', 'z=', builtin.spell_suggest, {})

	end,
}
