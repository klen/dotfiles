return function(defaults)
  local on_attach = defaults.on_attach
  return vim.tbl_extend("force", defaults, {
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true
      on_attach(client, bufnr)
    end,
    settings = {
      -- run = "onSave",
      format = { enable = true }, -- this will enable formatting
    },
  })
end
