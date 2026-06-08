local utils = require('utils')
local group = utils.autogroup('lsp', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  callback = function(ev)
    local bufnr = ev.buf
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not client then return end

    -- Enable document color if supported by the LSP server
    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = bufnr }, {
        style = "virtual",
      })
    end

    -- Autocompletion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        auto_import = true,
      })
    end

    -- Autoformat on save
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false, bufnr = bufnr, id = client.id, timeout_ms = 3000 }
        end,
        desc = 'Autoformat on save',
      })
    end

    -- Auto fixAll on save
    if client:supports_method('textDocument/codeAction') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.code_action({
            context = {
              only = { 'source.fixAll' },
              diagnostics = {},
            },
            apply = true,
          })
        end,
        desc = 'Auto fixAll on save',
      })
    end

    -- Bind LSP-related keymaps
    require('lsp.keymaps')(bufnr, client)
  end,
})
