return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
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
    end,
  }
}
