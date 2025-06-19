return {
  'saghen/blink.cmp',
  version = "1.*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  event = "InsertEnter",
  opts = {
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
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
  cmdline = {
    enabled = false,
  }
}
