local conf = function()
	require('nvim-treesitter').setup {
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
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	laze = false,
	config = conf
}
