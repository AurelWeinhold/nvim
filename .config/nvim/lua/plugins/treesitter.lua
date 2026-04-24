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
	build = ":TSUpdate",
	laze = false,
	config = conf
}
