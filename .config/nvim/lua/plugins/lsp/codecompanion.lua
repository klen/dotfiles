return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      cmd = { adapter = "lmstudio" },
      chat = { adapter = "lmstudio" },
      inline = { adapter = "lmstudio" },
    },
    adapters = {
      lmstudio = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "http://localhost:1234",
          },
        })
      end,
    },
    display = {
      action_palette = {
        provider = "snacks"
      }
    },
    strategies = {
      slash_commands = {
        ['buffer'] = {
          opts = { provider = "snacks" }
        },
        ['fetch'] = {
          opts = { provider = "snacks" }
        },
        ['file'] = {
          opts = { provider = "snacks" }
        },
        ['symbols'] = {
          opts = { provider = "snacks" }
        },
      },
    },
  },
}
