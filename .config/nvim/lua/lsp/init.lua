local utils = require('utils')

vim.api.nvim_create_autocmd('LspAttach', {
  group = utils.autogroup('lsp', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not client then return end

    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = bufnr }, {
        style = "virtual",
      })
    end

    -- Bind LSP-related keymaps
    require('lsp.keymaps')(bufnr, client)

    -- Bind LSP-related autocmds
    require('lsp.auto')(bufnr, client)
  end,
})
