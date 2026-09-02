local utils = require('utils')
local lsp_utils = require('lsp.utils')
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

    -- Bind LSP-related keymaps (per client)
    require('lsp.keymaps')(bufnr, client)

    -- Register the save hook only once per buffer: multiple LSP clients can
    -- attach (e.g. pyrefly + ruff), but we want a single deterministic pass.
    if vim.b[bufnr].lsp_save_hook then return end
    vim.b[bufnr].lsp_save_hook = true

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      buffer = bufnr,

      -- Run the following in order on save
      callback = function()
        -- 1) sort imports
        lsp_utils.apply_code_action(bufnr, 'source.organizeImports')

        -- 2) apply all available fixes (e.g. ruff, eslint, etc.)
        lsp_utils.apply_code_action(bufnr, 'source.fixAll')

        -- 3) formatting last, synchronous so it's the final pass before write
        if #vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' }) > 0 then
          vim.lsp.buf.format { async = false, bufnr = bufnr, timeout_ms = 3000 }
        end
      end,
      desc = 'FixAll and format on save',
    })
  end,
})
