local present, luasnip = pcall(require, "luasnip")
if not present then
  return
end

-- luasnip.config.set_config {
--   history = false,
--   updateevents = "TextChanged,TextChangedI",
-- }

-- Load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()
