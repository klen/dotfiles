return function(defaults)
  return vim.tbl_extend("force", defaults, {
    settings = {
      formatter = {
        alignEntries = false,
        columnWidth = 100,
      },
    },
  })
end
