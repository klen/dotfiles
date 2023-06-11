return {
  on_attach = require "lsp.utils.on_attach",
  handlers = require "lsp.utils.handlers",
  capabilities = require "lsp.utils.capabilities",
  flags = { debounce_text_changes = 150 },

  -- Setup diagnostic like this
  -- diagnostic = {
  --   disable = { 8006, 8008, 8010, 8011, 7006 },
  --   severity = { min = severity.INFO },
  -- },
}
