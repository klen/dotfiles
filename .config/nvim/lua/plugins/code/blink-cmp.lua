return {
  'saghen/blink.cmp',
  -- dependencies = {
  --   {
  --     "fang2hou/blink-copilot",
  --     opts = {
  --       max_attempts = 2,
  --       max_completions = 2,
  --     }
  --   }
  -- },
  version = "1.*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  event = "InsertEnter",
  opts = {
    -- Disable cmdline
    cmdline = { enabled = false },
    -- Disable chat
    enabled = function()
      return not vim.tbl_contains({ 'copilot-chat' }, vim.bo.filetype)
    end,
    sources = {
      default = { 'lsp' },
      --   default = { 'copilot', 'lsp', 'buffer' },
      --   providers = {
      --     copilot = {
      --       name = "copilot",
      --       module = "blink-copilot",
      --     },
      --   },
    },
    keymap = {
      ['<C-y>'] = {
        function(cmp)
          local copilot = require("copilot.suggestion")
          if cmp.is_visible() then
            cmp.select_and_accept()
          elseif copilot.is_visible() then
            copilot.accept()
          end
        end
      }
    },
    completion = {
      keyword = { range = "prefix" },
      accept = {
        auto_brackets = {
          enabled = false,
        }
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true,
      }
    }
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        require("copilot.suggestion").dismiss()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuClose',
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
