return {
	"nvim-lualine/lualine.nvim",
	requires = { 'nvim-tree/nvim-web-devicons', opt = true },
	config = function()

		require('lualine').setup {
			options = {
				theme = 'gruvbox',
				section_separators = '',
				component_separators = ''
			},
			sections = {
				lualine_c = { {'filename', path = 1} }
			}
		}

	end
}
