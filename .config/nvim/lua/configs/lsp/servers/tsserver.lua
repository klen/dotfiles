return function(defaults)
  local on_attach = defaults.on_attach
  return vim.tbl_extend("force", defaults, {
    filetypes = { "typescript", "javascript" },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- tsserver, stop messing with prettier da fuck!
      client.resolved_capabilities.document_formatting = false

      -- Optional improvements
      -- require("nvim-lsp-ts-utils").setup {}
    end,
  })
end
