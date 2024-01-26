require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close
			}
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
-- replace default z= with a telescope picker
vim.keymap.set('n', 'z=', builtin.spell_suggest, {})
