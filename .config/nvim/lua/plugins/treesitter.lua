conf = function()
	require('nvim-treesitter.configs').setup {
		ensure_installed = { "c", "cpp", "latex", "java", "markdown", "python" },
		highlight = {
			enable = true,
			-- for obsidian only:
			additional_vim_regex_highlighting = {"markdown"},
		},
		incremental_selection = { enable = true },
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = 'o',
				toggle_hl_groups = 'i',
				toggle_injected_languages = 't',
				toggle_anonymous_nodes = 'a',
				toggle_language_display = 'I',
				focus_language = 'f',
				unfocus_language = 'F',
				update = 'R',
				goto_node = '<cr>',
				show_help = '?',
			},
		},
		-- linting queries in playground
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = {"BufWrite", "CursorHold"},
		},
	}

	-- parsers
	local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
	parser_config.c.filetype_to_parsername = "c.doxygen"
	parser_config.latex.filetype_to_parsername = "latex"

end

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/playground"
	},
	build = ":TSUpdate",
	laze = false,
	config = conf
}
