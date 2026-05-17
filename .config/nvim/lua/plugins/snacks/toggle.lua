local snacks = require 'snacks'


vim.keymap.set('n', '<leader>o', '', { desc = '+opts' })

snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
snacks.toggle.option("list", { name = "List" }):map("<leader>ol")
snacks.toggle.option("number", { name = "Line Numbers" }):map("<leader>on")
snacks.toggle.option("relativenumber", { name = "Relative Line Numbers" }):map("<leader>or")

snacks.toggle.option("spell", { name = "Spell Check" }):map("<leader>os")
snacks.toggle.option("conceallevel", { name = "Conceal Level" }):map("<leader>oc")
snacks.toggle.option("foldenable", { name = "Fold Enable" }):map("<leader>of")
snacks.toggle.treesitter():map("<leader>ot")
snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ob")
snacks.toggle.diagnostics():map("<leader>od")

return {
  enabled = true,
}
