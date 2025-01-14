conf = function()
	local snippy = require('snippy')

	require('snippy').setup({
		mappings = {
			is = {
				["<Tab>"] = "expand_or_advance",
				["<S-Tab>"] = "previous",
			},
			x = {
				["<Tab>"] = "cut_text",
			},
		},
	})
end

return {
	"dcampos/nvim-snippy",
	config = conf,
}
