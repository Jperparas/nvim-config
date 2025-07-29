return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
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

      -- Optional: ESLint LSP for linting
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
    end,
  }
}
