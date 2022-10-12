local M = { }

function M.setup()
    local on_attach = function(client, bufnr)
        require('jdtls.setup').add_commands()
        require('jdtls').setup_dap()
        require('lsp-status').register_progress()

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
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
		vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)

        vim.keymap.set("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
        vim.keymap.set("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", bufopts)
        vim.keymap.set("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", bufopts)
        vim.keymap.set("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", bufopts)
        vim.keymap.set("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", bufopts)
        vim.keymap.set("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", bufopts)

        vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", bufopts)
          vim.api.nvim_exec([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]], false)

    end

    local root_markers = {'gradlew', 'pom.xml'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local home = os.getenv('HOME')

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

    -- NOTE(Aurel): This unfortunately needs to exist, as the LS is built using
    -- one "workspace" where every project is located.
    local workspace_dir = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
            allow_incremental_sync = true,
        };
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            ['java.format.settings.url'] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
            ['java.format.settings.profile'] = "GoogleStyle",
            java = {
                signatureHelp = { enabled = true };
                contentProvider = { preferred = 'fernflower' };
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*"
                    }
                };
                sources = {
                    organizeImports = {
                        starThreshold = 9999;
                        staticStarThreshold = 9999;
                    };
                };
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                    }
                };
                --configuration = {
                --runtimes = {
                --{
                --name = "java-17-openjdk",
                --path = "/usr/lib/jvm/java-17-openjdk",
                --},
                --}
                --};
            };
        },
        cmd = {
            'java-lsp', -- custom script
            workspace_dir
        },
        on_init = function(client, _)
            client.notify('workspace/didChangeConfiguration', { settings = config.settings })
        end
    }

    require('jdtls').start_or_attach(config)
end

return M
