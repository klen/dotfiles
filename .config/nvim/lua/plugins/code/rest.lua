-- Rest API client
--
return {
  "NTBBloodbath/rest.nvim",
  ft = "http",
  keys = {
    { "<leader>rr", "<cmd>Rest run<cr>", buffer = true, desc = "Run request" },
    { "<leader>rl", "<cmd>Rest last<cr>", buffer = true, desc = "Replay last request" },
    { "<leader>rs", "<cmd>Rest env select<cr>", buffer = true, desc = "Select env file" },
  },
  dependencies = { "luarocks.nvim" },
  config = function()
    vim.g.rest_nvim = {
      response = {
        ---Default response hooks
        ---@class rest.Config.Response.Hooks
        hooks = {
          ---@type boolean Decode the request URL segments on response UI to improve readability
          decode_url = true,
          ---@type boolean Format the response body using `gq` command
          format = true,
        },
      },
    }
    require("telescope").load_extension "rest"
  end,
}
