require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "cpp", "latex", "java" },
	highlight = { enable = true },
	indent = { enable = false },
	incremental_selection = { enable = true },
	keymaps = {
		init_selection = "gnn",
		node_incremental = "grn",
		scope_incremental = "grc",
		node_decremental = "grm",
	},
}

-- parsers
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.c.filetype_to_parsername = "c.doxygen"
parser_config.latex.filetype_to_parsername = "latex"
