require("obsidian").setup({
	dir = "~/Documents/secondBrain",
	notes_subdir = "notes",
	daily_notes = {
		folder = "notes/dailies",
	},
	-- update cursor positoin between obsidian and nvim
	use_advanced_uri = true,
	completion = {
		nvim_cmp = true,
	},
})

-- gf or obsidians gf if fitting
vim.keymap.set(
	"n",
	"gf",
	function()
		if require('obsidian').util.cursor_on_markdown_link() then
			return "<cmd>ObsidianFollowLink<CR>"
		else
			return "gf"
		end
	end,
	{ noremap = false, expr = true }
)
