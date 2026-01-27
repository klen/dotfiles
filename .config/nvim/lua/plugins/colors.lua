return {
  -- Define Neovim themes as a DSL in lua, with real-time feedback
  -- https://github.com/rktjmp/lush.nvim
  {
    "rktjmp/lush.nvim",
  },

  -- Enable colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "covid19",
      icons = {
        ft = {
          octo = "G ",
          gh = "G ",
          ["markdown.gh"] = "G ",
        },
        diagnostics = {
          Error = "E ",
          Warn = "W ",
          Hint = "H ",
          Info = "I ",
        },
        git = {
          added = "+ ",
          modified = "e ",
          removed = "- ",
        },
        kinds = {
          Array = "A ",
          Boolean = "b ",
          Class = "C ",
          Collapsed = "> ",
          Copilot = "L ",
          Enum = "E ",
          Event = "e ",
          Field = "f ",
          File = "",
          Folder = "> ",
          Function = "F ",
          Interface = "I ",
          Key = "k ",
          Keyword = "K ",
          Method = "F ",
          Module = "m ",
          Namespace = "N ",
          Number = "n ",
          Object = "o ",
          Package = "p ",
          Property = "",
          Reference = "r ",
          Snippet = "E ",
          String = "s ",
          Struct = "S ",
          Text = "s ",
          TypeParameter = "T ",
          Value = "v ",
          Variable = "v ",

          -- Codeium = "󰘦 ",
          -- Color = " ",
          -- Control = " ",
          -- Constant = "󰏿 ",
          -- Constructor = " ",
          -- EnumMember = " ",
          -- Null = " ",
          -- Operator = " ",
          -- Supermaven = " ",
          -- TabNine = "󰏚 ",
          -- Unit = " ",
        },
      },
    },
  },
}
