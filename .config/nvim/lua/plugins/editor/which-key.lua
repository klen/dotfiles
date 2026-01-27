return {
  "folke/which-key.nvim",
  opts = {
    icons = {
      rules = false,
      separator = "-",
      breadcrumb = ">>",
      -- mappings = false,
      keys = {
        Up = "<Up>",
        Down = "<Down>",
        Left = "<Left>",
        Right = "<Right>",

        C = "C-",
        M = "M-",
        D = "D-",
        S = "S-",

        CR = "<CR>",
        NL = "<CR>",

        Esc = "<Esc>",
        BS = "<BS>",
        Tab = "<Tab>",
        Space = "<Space>",

        ScrollWheelDown = "<ScrollDown>",
        ScrollWheelUp = "<ScrollUp>",

        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },
    spec = {
      mode = { "n" },
      { "<C-w>c", group = "close" },
    },
  },
}
