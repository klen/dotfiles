local utils = require('utils')
local keymaps = {
  -- LSP actions
  { keys = "gd",          func = vim.lsp.buf.definition,              desc = "Goto Definition",        has = "definitionProvider",    nowait = true },
  { keys = "gy",          func = vim.lsp.buf.type_definition,         desc = "Goto Type Definition",   has = "typeDefinitionProvider", nowait = true },
  { keys = "gi",          func = vim.lsp.buf.implementation,          desc = "Goto Implementation",    has = "implementationProvider", nowait = true },
  { keys = "gr",          func = vim.lsp.buf.references,              desc = "Goto References",        has = "referencesProvider",    nowait = true },
  { keys = "<leader>cs",  func = vim.lsp.buf.signature_help,          desc = "Signature Help",         has = "signatureHelpProvider" },
  { keys = "gl",          func = vim.lsp.codelens.run,                desc = "Run CodeLens Action",    has = "codeLensProvider" },
  { keys = "K",           func = vim.lsp.buf.hover,                   desc = "Hover Documentation",    has = "hoverProvider" },

  -- Workspace management
  { keys = "<leader>lw",  func = '',                                  desc = "+workspace" },
  { keys = "<leader>lwa", func = vim.lsp.buf.add_workspace_folder,    desc = "Add Workspace Folder" },
  { keys = "<leader>lwr", func = vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace Folder" },
  {
    keys = "<leader>lwl",
    func = function()
      utils.pprint(vim.lsp.buf.list_workspace_folders())
    end,
    desc = "List Workspace Folders"
  },

  -- Code actions
  { keys = "<leader>cr", func = vim.lsp.buf.rename,                                 desc = "Rename Symbol" },
  { keys = "<leader>ca", func = vim.lsp.buf.code_action,                            desc = "Code Action",           mode = { "n", "v" } },
  { keys = "<leader>cf", func = function() vim.lsp.buf.format { async = true } end, desc = "Format Buffer with LSP" },
  {
    keys = "<leader>cl",
    func = function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.fixAll" },
          diagnostics = {},
        },
        apply = true
      })
    end,
    desc = "Fix all auto-fixable issues in buffer"
  },

  -- Diagnostics
  { keys = "<leader>cd", func = vim.diagnostic.open_float,                                       desc = "Show diagnostics in floating window" },
  { keys = "<leader>cq", func = function() vim.diagnostic.setloclist({ open = true }) end,       desc = "Set location list with diagnostics" },
  { keys = "<C-n>",      func = function() vim.diagnostic.jump { count = 1, float = true } end,  desc = "Go to next diagnostic" },
  { keys = "<C-p>",      func = function() vim.diagnostic.jump { count = -1, float = true } end, desc = "Go to previous diagnostic" },

}

return function(bufnr, client)
  vim.keymap.set('n', '<leader>l', '', { desc = '+lsp' })                              -- Prefix for code-related commands
  vim.keymap.set('n', '<leader>li', '<cmd>che vim.lsp<cr>', { desc = 'LSP: Info' })    -- Inspect LSP client info
  vim.keymap.set('n', '<leader>lr', '<cmd>lsp restart<cr>', { desc = 'LSP: Restart' }) -- Restart LSP client
  vim.keymap.set('n', '<leader>ls', '<cmd>lsp stop<cr>', { desc = 'LSP: Stop' })       -- Stop LSP client

  vim.keymap.set('n', '<leader>c', '', { desc = '+code' })                             -- Prefix for code-related commands

  for _, km in ipairs(keymaps) do
    if not km.has or client.server_capabilities[km.has] then
      vim.keymap.set(
        km.mode or "n",
        km.keys,
        km.func,
        { buffer = bufnr, desc = "LSP: " .. km.desc, nowait = km.nowait }
      )
    end
  end
end
