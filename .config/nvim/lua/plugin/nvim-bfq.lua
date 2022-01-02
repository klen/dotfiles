-- Better quickfix window in Neovim, polish old quickfix window
-- https://github.com/kevinhwang91/nvim-bqf
return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",

  -- Configure
  config = function()
    cmd [[
      hi BqfPreviewBorder guifg=#50a14f ctermfg=71
      hi link BqfPreviewRange Search
    ]]

    require("bqf").setup {
      auto_enable = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        should_preview_cb = function(bufnr)
          local ret = true
          local filename = api.nvim_buf_get_name(bufnr)
          local fsize = fn.getfsize(filename)
          -- file size greater than 100k can't be previewed automatically
          if fsize > 100 * 1024 then
            ret = false
          end
          return ret
        end,
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    }
  end,
}
