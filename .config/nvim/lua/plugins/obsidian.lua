require("obsidian").setup({
	dir = "~/Documents/secondBrain",
	notes_subdir = "to_sort",
	daily_notes = {
		folder = "notes/dailies",
	},
	-- update cursor positoin between obsidian and nvim
	use_advanced_uri = true,
	completion = {
		nvim_cmp = true,
	},
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return  suffix .. "-" .. tostring(os.time())
	end
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
