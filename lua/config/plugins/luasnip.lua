return { {
  "L3MON4D3/LuaSnip",

  -- follow latest release.
  dependencies = { 'saghen/blink.cmp',
    "rafamadriz/friendly-snippets" },
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({
      vim.fn.stdpath("config") .. "/snippets"
    })
  end
} }
