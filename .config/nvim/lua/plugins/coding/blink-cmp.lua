return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<C-y>"] = {
        function(cmp)
          -- First try to accept cmp suggestion
          if cmp.is_visible() then
            return cmp.select_and_accept()
          end

          -- Fallback to copilot suggestion accept
          local ok, copilot = pcall(require, "copilot.suggestion")
          if ok and copilot.is_visible() then
            return copilot.accept()
          end
        end,
      },
      ["<C-k>"] = { "snippet_forward", "fallback" },
      ["<C-j>"] = { "snippet_backward", "fallback" },
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        local ok, copilot = pcall(require, "copilot.suggestion")
        if ok and copilot.is_visible() then
          copilot.dismiss()
          vim.b.copilot_suggestion_hidden = true
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
