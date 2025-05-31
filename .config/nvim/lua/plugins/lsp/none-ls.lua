local on_attach = require "lsp.utils.on_attach"

return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  config = function()
    local cfg = require "config"
    local null_ls = require "null-ls"

    null_ls.setup {
      debug = cfg.debug,

      handlers = require "lsp.utils.handlers",
      on_attach = function(client, bufnr)
        -- Enable formatting
        client.config.format = true
        return on_attach(client, bufnr)
      end,

      diagnostics_format = "#{c} #{m} (#{s})",

      sources = {

        null_ls.builtins.formatting.prettier.with {
          filetypes = {
            "css",
            "scss",
            "less",
            "json",
            "yaml",
            "markdown",
            "graphql",
          },
        },

        require "none-ls.diagnostics.eslint_d",
        require "none-ls.formatting.eslint_d",

        require "none-ls.formatting.rustfmt",

        -- pip install ruff
        require "none-ls.diagnostics.ruff",
        require "none-ls.formatting.ruff",

        -- pip install black
        null_ls.builtins.formatting.black,

        -- Lua
        -- cargo install stylua
        -- null_ls.builtins.formatting.stylua,
      },
    }

    -- Disable sources by config
    local disable = cfg:get("null_ls.disable", {})
    for method, sources in pairs(disable) do
      for _, name in ipairs(sources) do
        null_ls.disable { name = name, method = "NULL_LS_" .. method:upper() }
      end
    end
  end,
}
