return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      debug = false,
      on_attach = require "plugin/lsp/on_attach",

      diagnostics_format = "#{c} #{m} (#{s})",
      sources = {

        -- JS, TypeScript (TODO: formatting -> eslint_d+prettier_plugin)

        -- npm -g i eslint prettier eslint_d \
        --   eslint-plugin-prettier eslint-plugin-unicorn @typescript-eslint/eslint-plugin
        --   eslint-config-airbnb-base eslint-config-airbnb-typescript eslint-config-prettier

        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.eslint,

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
        null_ls.builtins.diagnostics.pylama,
        -- pip install pylint
        -- null_ls.builtins.diagnostics.pylint,

        -- Lua
        -- cargo install stylua
        null_ls.builtins.formatting.stylua,

        -- Actions
        -- null_ls.builtins.code_actions.refactoring,
      },
    }
  end,
}
