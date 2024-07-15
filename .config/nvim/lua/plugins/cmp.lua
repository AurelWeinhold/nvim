vim.o.completeopt = "menu,menuone,noselect"

local cmp = require('cmp')
cmp.setup({
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'buffer', option = {
			-- https://github.com/hrsh7th/nvim-cmp/issues/453: allow multibyte
			-- matching, e.g. ä, ö, ü, á, etc.
			keyword_pattern = [[\k\+]]
		}},
		{ name = 'path' },
		{ name = 'snippy' },
		{ name = 'omni' },
	}),
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false
		}),
	},
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end,
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.recently_used,
			require("clangd_extensions.cmp_scores"),
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		}
	},
	formatting = {
		format = require('lspkind').cmp_format({
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		})
	}
})
