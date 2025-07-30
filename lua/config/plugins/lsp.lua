return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Lua LSP
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript LSP
      require("lspconfig").ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        settings = {
          typescript = {
            preferences = {
              disableSuggestions = false,
            }
          },
          javascript = {
            preferences = {
              disableSuggestions = false,
            }
          }
        }
      })

      -- ESLint LSP for linting
      require("lspconfig").eslint.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        settings = {
          eslint = {
            enable = true,
            format = { enable = true },
            lint = { enable = true },
            autoFixOnSave = true,
          }
        }
      })

      -- Bash LSP
      require("lspconfig").bashls.setup({
        capabilities = capabilities,
        filetypes = { "sh", "bash" },
        settings = {
          bashIde = {
            shellcheckPath = "shellcheck",
          }
        }
      })

      -- Emmet LSP for HTML/JSX completion
      require("lspconfig").emmet_language_server.setup({
        capabilities = capabilities,
        filetypes = { 
          "css", "eruby", "html", "javascript", "javascriptreact", 
          "less", "sass", "scss", "pug", "typescriptreact" 
        },
        init_options = {
          includeLanguages = {},
          excludeLanguages = {},
          extensionsPath = {},
          preferences = {},
          showAbbreviationSuggestions = true,
          showExpandedAbbreviation = "always",
          showSuggestionsAsSnippets = false,
          syntaxProfiles = {},
          variables = {},
        },
      })

      -- YAML LSP
      require("lspconfig").yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            validate = true,
            completion = true,
            hover = true,
            format = {
              enable = true,
            }
          }
        }
      })

      -- Common LSP autocmd for formatting on save
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  },
  -- Java LSP (JDTLS) -
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local setup = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
          '-configuration', vim.fn.expand('~/.config/jdtls-config_linux'),
          '-data', vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir
        },
        root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
        capabilities = capabilities,
        settings = {
          java = {}
        },
        init_options = {
          bundles = {}
        },
      }
      require('jdtls').start_or_attach(setup)
    end,
  },
}
