local t = {

  luafmt = {
    formatCommand = "luafmt -i 2 --stdin",
    formatStdin = true,
  },

  stylua = {
    formatCommand = "stylua --config-path $HOME/.config/stylua/stylua.toml -",
    formatStdin = true,
  },

  flake8 = {
    lintCommand = "flake8 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    prefix = "flake8",
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n %m" },
  },

  isort = {
    formatCommand = "isort --profile black -l 100 -",
    formatStdin = true,
  },

  autopep8 = {
    formatCommand = "autopep8 --max-line-length 100 -",
    formatStdin = true,
  },

  yapf = {
    formatCommand = "yapf",
    formatStdin = true,
  },

  black = {
    formatCommand = "black --quiet -l 100 -",
    formatStdin = true,
  },

  mypy = {
    prefix = "mypy",
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports --disable-error-code name-defined --cache-dir=/dev/null",
    lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
  },

  prettier = {
    formatCommand = "prettier --stdin-filepath ${INPUT}",
    formatStdin = true,
  },

  prettier_sh = {
    formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}",
    formatStdin = true,
    lintSeverity = 2,
  },

  shellcheck = {
    lintCommand = "shellcheck -f gcc -x",
    lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
  },

  yaml = {
    lintCommand = "yamllint -f parsable -",
    lintStdin = true,
    formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}",
    formatStdin = true,
    lintSeverity = 2,
  },

  eslint_d = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true,
    lintSeverity = 2,
  },

  pylint = {
    lintCommand = "pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}",
    lintStdin = false,
    lintFormats = { "%f:%l:%c:%t:%m" },
    lintOffsetColumns = 1,
    lintCategoryMap = { I = "H", R = "I", C = "I", W = "W", E = "E", F = "Ek" },
  },
}

local filetypeConfigMap = {
  typescript = { t.eslint_d },
  javascript = { t.eslint_d },
  typescriptreact = { t.eslint_d },
  javascriptreact = { t.eslint_d },
  lua = { t.luafmt },
  sh = { t.prettier_sh },
  zsh = { t.prettier_sh },
  yaml = { t.yaml },
  python = { t.flake8, t.black, t.isort },
}

return function(defaults)
  return vim.tbl_extend("force", defaults, {
    init_options = {
      documentFormatting = true,
      codeAction = true,
    },
    settings = {
      -- rootMarkers = {vim.fn.getcwd()},
      -- rootMarkers = {".git/"},
      languages = filetypeConfigMap,
    },
    filetypes = vim.tbl_keys(filetypeConfigMap),
    root_dir = function()
      return fn.getcwd()
    end,
    on_attach = defaults.on_attach,
  })
end
