return {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "LazyVim", words = { "LazyVim" } },
          { path = "snacks.nvim", words = { "Snacks" } },
          { path = "lazy.nvim", words = { "LazyVim" } },
        },
      },
    },
  },
}
