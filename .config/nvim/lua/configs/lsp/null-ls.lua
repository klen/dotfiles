return function()
  local null_ls = require "null-ls"

  null_ls.config {
    debug = true,

    diagnostics_format = "#{c} #{m} (#{s})",
    sources = {

      -- JS, TypeScript (TODO: formatting -> eslint_d+prettier_plugin)
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.formatting.prettier,

      -- Python
      -- pip install black
      null_ls.builtins.formatting.black.with {
        extra_args = {
          "--line-length=100",
        },
      },
      -- pip install isort
      null_ls.builtins.formatting.isort.with {
        extra_args = {
          "--line-length=100",
          "--gitignore",
        },
      },
      -- pip install pylama
      null_ls.builtins.diagnostics.pylama.with {
        extra_args = {
          "--max-line-length=100",
        },
      },

      -- Lua
      -- cargo install stylua
      null_ls.builtins.formatting.stylua,
    },
  }

  require("lspconfig")["null-ls"].setup {
    on_attach = require "configs/lsp/on_attach",
    capabilities = require "configs/lsp/capabilities",
    handlers = require "configs/lsp/handlers",
  }
end
