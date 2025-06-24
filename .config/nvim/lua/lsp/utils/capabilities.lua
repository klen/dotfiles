-- Setup capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
  "plaintext",
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

if pcall(require, "lsp-status") then
  capabilities.window = capabilities.window or {}
  capabilities.window.workDoneProgress = true
end

if pcall(require, "blink.cmp") then
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
end

if pcall(require, "ufo") then
  capabilities.textDocument.foldingRange = {
    lineFoldingOnly = true,
    dynamicRegistration = false,
  }
end

return capabilities
