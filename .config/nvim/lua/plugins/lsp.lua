lsp_conf = function()
	local nvim_lsp = require('lspconfig')

	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

	local on_attach = function(client, bufnr)

		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Mappings
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', '<leader>ff', function() vim.lsp.buf.format({
			filter = function(client)
				return client.name == "null-ls"
			end,
			async = true,
		}) end, bufopts)

		-- telescope keybindings
		local telescope_builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>s', telescope_builtin.lsp_workspace_symbols, bufopts)
		vim.keymap.set('n', '<leader>fs', telescope_builtin.lsp_document_symbols, bufopts)
		vim.keymap.set('n', '<leader>d', telescope_builtin.diagnostics, bufopts)
		vim.keymap.set('n', '<leader>fd', telescope_builtin.lsp_definitions, bufopts)
		vim.keymap.set('n', '<leader>td', telescope_builtin.lsp_type_definitions, bufopts)
		vim.keymap.set('n', '<leader>fi', telescope_builtin.lsp_implementations, bufopts)
		vim.keymap.set('n', '<leader>fr', telescope_builtin.lsp_references, bufopts)
	end

	-- support LSP snippets
	local capabilities = require('cmp_nvim_lsp').default_capabilities();

	-- loop over servers, that don't require special configuration
	local servers = { "clangd", "vimls", "texlab", "bashls", "cmake", "ts_ls", "pyright", "dartls"}
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end

	require('clangd_extensions').setup {
		server = {
			on_attach = on_attach,
			capabilities = capabilities,
		},
		extensions = {
			inlay_hints = {
				only_current_line = true,
				parameter_hints_prefix = "",
				max_len_align = true,
				right_align = true,
			}
		},
	}


end

null_conf = function()
	-- null-ls
	local null_ls = require('null-ls')
	null_ls.setup {
		sources = {
			null_ls.builtins.formatting.clang_format, -- formatting c using clang_format
			null_ls.builtins.formatting.autopep8.with({ -- formatting python using autopep8
				"--aggressive", "--aggressive"
			}),
		},
	}
end


return {
	{
		"neovim/nvim-lspconfig",
		priority = 50,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			"p00f/clangd_extensions.nvim",
		},
		config = lsp_conf,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = null_conf,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java"
	}
}
