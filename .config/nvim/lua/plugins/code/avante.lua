return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  build = "make",
  opts = {
    provider = "ollama",
    providers = {
      ollama = {
        host = "http://localhost:11434",
        model = "qwen3",
      },
    },
    mappings = {
      confirm = {
        focus_window = "<C-f>",
      }
    },
  }
}
