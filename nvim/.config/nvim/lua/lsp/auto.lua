local utils = require('utils')
local group = utils.autogroup('lsp', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
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

    -- Autoformat and fixAll on save if supported by the LSP server
    local has_formatting = client:supports_method('textDocument/formatting')
    local has_fix_all = client:supports_method('textDocument/codeAction') and
        client.server_capabilities.codeActionProvider and
        vim.tbl_contains(client.server_capabilities.codeActionProvider.codeActionKinds or {}, 'source.fixAll')

    if has_formatting or has_fix_all then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        buffer = bufnr,
        callback = function()
          if has_formatting then
            vim.lsp.buf.format { async = false, bufnr = bufnr, id = client.id, timeout_ms = 3000 }
          end
          if has_fix_all then
            vim.lsp.buf.code_action({
              context = {
                only = { 'source.fixAll' },
                diagnostics = {},
              },
              apply = true,
            })
          end
        end,
        desc = 'Autoformat and fixAll on save',
      })
    end

    -- Bind LSP-related keymaps
    require('lsp.keymaps')(bufnr, client)
  end,
})
