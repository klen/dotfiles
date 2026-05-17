local utils = require('utils')

return function(bufnr, client)
  -- Autoformat on save
  if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = utils.autogroup('lsp', {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false, bufnr = bufnr, id = client.id, timeout_ms = 3000 }
      end,
      desc = 'Autoformat on save',
    })
  end

  -- Autocompletion
  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end
end
