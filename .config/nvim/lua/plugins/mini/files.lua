return {
  "echasnovski/mini.files",
  lazy = true,
  keys = {
    {
      "<leader>dd",
      function()
        require("mini.files").open()
      end,
      desc = "Open Files Explorer"
    },
    {
      "<leader>df",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
      end,
      desc = "Locate the current File"
    }
  },
  opts = {
    content = {
      filter = function(fs_entry)
        -- Show all files if `show_dotfiles` is true, otherwise hide dotfiles
        return vim.g.show_dotfiles or not vim.startswith(fs_entry.name, '.')
      end,
    },
    windows = {
      preview = true,
      width_preview = 50,
    }
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)
        MiniFiles.go_in({ close_on_file = true })
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    local filter_show = function() return true end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      vim.g.show_dotfiles = not vim.g.show_dotfiles
      local new_filter = vim.g.show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        -- Tweak keys to your liking
        map_split(buf_id, '<C-s>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
        map_split(buf_id, '<C-t>', 'tab')

        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle dotfiles' })

        -- Map enter
        vim.keymap.set('n', '<CR>', function()
          MiniFiles.go_in({ close_on_file = true })
        end, { buffer = buf_id, desc = 'Open file under cursor' })

        -- Close the explorer with <C-c>
        vim.keymap.set('n', '<C-c>', function()
          MiniFiles.close()
        end, { buffer = buf_id, desc = 'Close Files Explorer' })
      end
    })
  end
}
