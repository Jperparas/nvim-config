return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      -- Emmet LSP for HTML/JSX completion
      require("lspconfig").emmet_language_server.setup({
        capabilities = capabilities,
        filetypes = { 
          "css", "eruby", "html", "javascript", "javascriptreact", 
          "less", "sass", "scss", "pug", "typescriptreact" 
        },
        init_options = {
          ---@type table<string, string>
          includeLanguages = {},
          --- @type string[]
          excludeLanguages = {},
          --- @type string[]
          extensionsPath = {},
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
          preferences = {},
          --- @type boolean Defaults to `true`
          showAbbreviationSuggestions = true,
          --- @type "always" | "never" Defaults to `"always"`
          showExpandedAbbreviation = "always",
          --- @type boolean Defaults to `false`
          showSuggestionsAsSnippets = false,
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
          syntaxProfiles = {},
          --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
          variables = {},
        },
      })
    end,
  }
}
