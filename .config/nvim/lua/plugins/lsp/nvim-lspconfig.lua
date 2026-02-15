return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      ["*"] = require("plugins/lsp/servers/common"),
      ["lua_ls"] = require("plugins/lsp/servers/lua_ls"),
    },
  },
}
