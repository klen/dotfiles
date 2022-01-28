return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local cfg = require "config"
    local null_ls = require "null-ls"

    null_ls.setup {
      debug = cfg.debug,
      on_attach = require "plugin.lsp.on_attach",
      ---@diagnostic disable-next-line: redundant-parameter
      handlers = require "plugin.lsp.handlers" "null-ls",

      diagnostics_format = "#{c} #{m} (#{s})",
      sources = {

        -- JS, TypeScript (TODO: formatting -> eslint_d+prettier_plugin)

        -- npm -g i eslint prettier eslint_d \
        --   eslint-plugin-prettier eslint-plugin-unicorn @typescript-eslint/eslint-plugin
        --   eslint-config-airbnb-base eslint-config-airbnb-typescript eslint-config-prettier

        -- null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.code_actions.eslint,
        null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.formatting.eslint,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.prettier.with {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            -- "html",
            "json",
            "yaml",
            "markdown",
            "graphql",
          },
        },

        -- Python
        -- pip install black
        null_ls.builtins.formatting.black,

        -- pip install isort
        null_ls.builtins.formatting.isort.with {
          extra_args = {
            "--line-length=100",
            "--gitignore",
          },
        },
        -- pip install pylama
        null_ls.builtins.diagnostics.pylama.with {
          timeout = 5000,
        },
        -- pip install pylint
        -- null_ls.builtins.diagnostics.pylint,

        -- Lua
        -- cargo install stylua
        null_ls.builtins.formatting.stylua,

        -- Actions
        -- null_ls.builtins.code_actions.refactoring,
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
