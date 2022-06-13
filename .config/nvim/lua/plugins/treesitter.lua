require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "cpp", "latex", "java" },
    highlight = {
        enable = true,
        -- TODO: Remove as soon as this is supported by default.
        -- NOTE: Makes spell checking work as expected y using vims built-in
        --       highlighting underneath the treesitter highlighting.
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = false },
    incremental_selection = { enable = true }
}

-- colors
require('nvim-treesitter.highlight')
local hlmap = vim.treesitter.highlighter.hl_map
hlmap["method"] = "blue"
hlmap["function"] = "blue"

-- parsers
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.c.filetype_to_parsername = "c.doxygen"
parser_config.latex.filetype_to_parsername = "latex"
