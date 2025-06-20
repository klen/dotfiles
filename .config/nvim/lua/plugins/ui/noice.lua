return {
  {
    "folke/noice.nvim",
    event = "VeryLazy", -- Load this plugin as late as possible to optimize startup time
    dependencies = {
      -- 'nui.nvim' is essential for Noice's UI popups and components.
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- General UI views configuration
      views = {
        -- Configuration for the popup menu (e.g., from completion)
        popupmenu = {
          enabled = true, -- Enable Noice to manage popup menus for a consistent look
        },
        -- Configuration for displaying function/method signatures
        signature = {
          enabled = true, -- Enable Noice to manage signature help popups
        },
      },

      -- Language Server Protocol (LSP) specific UI enhancements
      lsp = {
        progress = {
          enabled = true, -- Enable displaying LSP progress messages (e.g., "Indexing...")
        },
        signature = {
          auto_open = { enabled = false }, -- Disable automatic signature help popup when typing
        },
        -- Overrides default markdown rendering for LSP documentation to use Treesitter,
        -- which provides more accurate and stylized rendering for better readability,
        -- especially when integrated with completion plugins like nvim-cmp.
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- Integrates with nvim-cmp for rich documentation
        },
      },

      -- Message routing rules to control which messages are displayed or suppressed
      routes = {
        {
          filter = {
            event = "msg_show", -- Apply this filter to messages being shown
            -- Suppress common, less critical messages that can clutter the UI.
            -- These patterns are often seen after file operations or movements.
            any = {
              { find = '%d+L, %d+B' },     -- E.g., "10L, 20B" (lines, bytes info)
              { find = '; after #%d+' },   -- Git merge messages
              { find = '; before #%d+' },  -- Git merge messages
              { find = '%d fewer lines' }, -- File diff messages
              { find = '%d more lines' },  -- File diff messages
            },
          },
          opts = { skip = true }, -- Skip displaying these messages altogether
        },
      },

      -- Presets offer quick ways to configure common Noice layouts and behaviors.
      presets = {
        bottom_search = true,         -- Use a classic bottom command line for search prompts
        -- command_palette = false, -- (Commented out) Option to position command line and popup menu together
        long_message_to_split = true, -- Send very long messages to a dedicated split window
        inc_rename = false,           -- (Commented out) Disable input dialog for inc-rename.nvim
      },

      -- Detailed configuration for the command-line (cmdline) UI.
      cmdline = {
        view = "cmdline_popup", -- Display command line input in a floating popup window
        format = {
          -- Default command line format
          cmdline = {
            pattern = "", -- Matches all commands by default
            icon = "", -- Custom icon for general commands
            lang = "vim", -- Syntax highlighting language
            icon_hl_group = "Normal", -- Highlight group for the icon
            opts = {
              size = {
                width = 100,     -- Fixed width for the command line popup
                height = "auto", -- Auto-adjust height based on content
              },
            },
          },
          -- Format for searching downwards
          search_down = {
            kind = "search",
            pattern = "^/",
            icon = " ", -- Search icon with down arrow
            lang = "regex",
            icon_hl_group = "Normal",
            opts = {
              size = { width = "100%" } -- Full width for search input
            }
          },
          -- Format for searching upwards
          search_up = {
            kind = "search",
            pattern = "^%?",
            icon = " ", -- Search icon with up arrow
            lang = "regex",
            icon_hl_group = "Normal",
            opts = {
              size = { width = "100%" }
            }
          },
          -- Format for shell commands initiated with `!`
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash", icon_hl_group = "Normal", title = "Shell" },
          -- Format for Lua commands
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua", icon_hl_group = "Normal" },
          -- Format for help commands
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?", icon_hl_group = "Normal" },
          -- Format for generic input dialogs (e.g., `vim.ui.input()`)
          input = { view = "cmdline_input", icon = "󰥻 ", icon_hl_group = "Normal" },
        },
        -- General options for all command line views
        opts = {
          size = {
            width = 100,
            height = "auto",
          },
          win_options = {
            -- Highlight group for the window itself and its border
            winhighlight = "Normal:Normal,FloatBorder:Normal",
          },
        },
      },
    },
    -- `init` function runs before the plugin is set up, often used for keymaps.
    init = function()
      local cfg = require("config") -- Assuming 'config' module is loaded
      -- Add a keymap to open the Noice message history/dashboard.
      table.insert(cfg.keymaps, {
        "<leader>fn",
        function()
          require("noice").cmd("all") -- Open the Noice 'all messages' view
        end,
        desc = "Find notifies",
      })
    end,
  },
}
