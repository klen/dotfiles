local M = {}

M.config = {

  -- Terminal size
  split = "belowright 20split",

  -- Map keys
  mapping = true,

  -- Supported languages
  languages = {
    javascript = "node",
    lua = "lua",
    python = "python3",
    ruby = "ruby",
    typescript = "ts-node",
  },
}

-- open new terminal
function M.open(cmd)
  vim.cmd(M.config.split)
  vim.cmd "wincmd J"
  local winnr = vim.fn.win_getid()
  local bufnr = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_set_current_buf(bufnr)
  vim.api.nvim_win_set_buf(winnr, bufnr)
  vim.fn.termopen(cmd)
end

-- start_repl starts a REPL for the current filetype, e.g. a Python file will
-- open a Python3 REPL
function M.start_repl()
  local filetype = vim.bo.filetype
  local cmd = M.config.languages[filetype]
  M.open(cmd)
end

-- run_code runs the current file
function M.run_file()
  local filetype = vim.bo.filetype
  local cmd = M.config.languages[filetype]
  M.open(cmd .. " " .. vim.fn.expand "%")
end

function M.map_keys()
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<leader>rr",
    "<cmd>lua require('runner').run_file()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<leader>rl",
    "<cmd>lua require('runner').start_repl()<CR>",
    { noremap = true, silent = true }
  )
end

-- Setup the plugin
function M.setup(cfg)
  -- Update config
  if cfg ~= nil then
    M.config = vim.tbl_deep_extend("force", M.config, cfg)
  end

  -- Setup mapping
  if M.config.mapping then
    for lang, _ in pairs(M.config.languages) do
      vim.cmd("au FileType " .. lang .. " lua require('runner').map_keys()")
    end
  end
end

return M
