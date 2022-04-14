local clangd = require('lspconfig')["clangd"]

-- add lsp-status clangd extension to the handler
clangd.init_options = { clangdFileStatus = true }
clangd.handlers = require('lsp-status').extensions.clangd.setup()
