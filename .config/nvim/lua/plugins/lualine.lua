return {
	"nvim-lualine/lualine.nvim",
	requires = {
		{ 'nvim-tree/nvim-web-devicons', opt = true },
		{ 'nvim-navic' }
	},
	config = function()

		require('lualine').setup {
			options = {
				theme = 'gruvbox',
				section_separators = '',
				component_separators = ''
			},
			sections = {
				lualine_b = { {'filename', path = 1}, 'diff' },
				lualine_c = { 'diagnostics' }
			},
			tabline = {
				lualine_b = { { 'tabs', mode = 1 } },
				lualine_x = { 'navic' },
				lualine_y = { 'branch' },
			},
		}

	end
}
