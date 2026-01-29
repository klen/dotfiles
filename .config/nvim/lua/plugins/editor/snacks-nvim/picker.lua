return {
  win = {
    input = {
      keys = {
        ["<C-j>"] = { "focus_list", mode = { "i", "n" } },
        ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
      },
    },
    list = {
      keys = {
        ["<C-c>"] = { "close", mode = { "i", "n" } },
        ["<C-k>"] = { "focus_input", mode = { "i", "n" } },
        ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
      },
    },
    preview = {
      keys = {
        ["<C-c>"] = { "close", mode = { "i", "n" } },
        ["<C-h>"] = { "focus_input", mode = { "i", "n" } },
      },
      wo = {
        wrap = true,
      },
    },
  },
  icons = {
    files = {
      enabled = false,
    },
    git = {
      enabled = false,
    },
  },
}
