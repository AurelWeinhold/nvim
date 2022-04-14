vim.o.completeopt = "menu,menuone,noselect"

local cmp = require('cmp')

cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'snippy' },
    }),
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        }),
    },
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end,
    }
})
