return {
  "NTBBloodbath/rest.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("rest-nvim").setup {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
    }

    vim.cmd "au FileType http nmap <buffer><silent> <leader>rr <plug>RestNvim"
    vim.cmd "au FileType http nmap <buffer><silent> <leader>rp <plug>RestNvimPreview"
    vim.cmd "au FileType http nmap <buffer><silent> <leader>rl <plug>RestNvimLast"
  end,
}
