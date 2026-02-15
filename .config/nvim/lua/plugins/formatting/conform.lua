return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      javascript = { "biome-check" },
      javascriptreact = { "biome-check" },
      typescript = { "biome-check" },
      typescriptreact = { "biome-check" },
      json = { "biome-check" },
      css = { "biome-check" },
      html = { "biome-check" },
      markdown = { "rumdl" },
    },
  },
}
