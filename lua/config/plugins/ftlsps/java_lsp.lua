return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local capabilities = require('blink.cmp').get_lsp_capabilities() -- Assign to variable
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
          '-data', vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir -- Added missing ~
        },
        root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
        capabilities = capabilities, -- Add this line
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
