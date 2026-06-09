return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      completion = {
        callSnippet = "Disable",
        keywordSnippet = "Disable",
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  }
}
