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
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format({
	  filter = function(client)
		  return client.name == "null-ls"
	  end,
	  async = true,
  }) end, bufopts)
end

-- support LSP snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- loop over servers, that don't require special configuration
local servers = { "vimls", "texlab", "bashls", "cmake", "tsserver", "pyright" }
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


-- null-ls
local null_ls = require('null-ls')
null_ls.setup {
	sources = {
		-- diagnostic
		--null_ls.builtins.diagnostics.todo_comments, -- diagnostic warnings at todos
		--null_ls.builtins.diagnostics.ltrs.with({
		--	extra_filetypes = { "latex" },
		--	args = {
		--		"--hostname", "http://localhost", "-p", "8081",
		--		"check", "-m", "-r", "--text", "$TEXT"
		--	},
		--}),
		--null_ls.builtins.diagnostics.vale.with({ -- prose linter
		--	extra_filetypes = { "latex" },
		--}),
		-- formatting
		null_ls.builtins.formatting.clang_format, -- formatting using clang_format
		null_ls.builtins.formatting.trim_newlines, -- remove trailing new lines
		-- code actions
		--null_ls.builtins.code_actions.ltrs.with({
		--	extra_filetypes = { "latex" },
		--	args = {
		--		"--hostname", "http://localhost", "-p", "8081",
		--		"check", "-m", "-r", "--text", "$TEXT"
		--	},
		--}),
	},
}
