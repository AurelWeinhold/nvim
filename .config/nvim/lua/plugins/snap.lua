local snap = require('snap')

local fzf = snap.get'consumer.fzf'
local producer_file = snap.get'producer.ripgrep.file'.args({
    '--hidden',
    '--iglob', '!.git/*'
})
local producer_grep = snap.get'producer.ripgrep.vimgrep'
local preview_file = snap.get'preview.file'
local preview_grep = snap.get'preview.vimgrep'

-- find in cwd
snap.register.map( {'n'}, { "<leader>f"}, function()
    snap.run {
        producer = fzf(producer_file),
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = { preview_file }
    }
end)

-- grep cwd
snap.register.map( {'n'}, { "<leader>fg"}, function()
    snap.run {
        prompt = "Grep>",
        producer = snap.get'consumer.limit'(10000, producer_grep.args({
            '--smart-case',
        })),
        select = snap.get'select.vimgrep'.select,
        multiselect = snap.get'select.vimgrep'.multiselect,
        views = { preview_grep }
    }
end)

-- grep help
snap.register.map( {'n'}, { "<leader>fh"}, function()
    snap.run {
        prompt = "Help>",
        producer = fzf(snap.get'producer.vim.help'),
        select = snap.get'select.help'.select,
        views = { snap.get'preview.help' }
    }
end)

-- find nvim config files
snap.register.map( {'n'}, { "<leader>fv"}, function()
    snap.run {
        prompt = "Find config>",
        producer = fzf(producer_file.args({}, os.getenv('XDG_CONFIG_HOME') .. "/nvim")),
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = { preview_file }
    }
end)
