return function(defaults)
  return vim.tbl_extend("force", defaults, {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end
