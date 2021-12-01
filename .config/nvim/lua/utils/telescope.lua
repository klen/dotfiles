local M = {}

function M.config()
  require("telescope.builtin").git_files {
    shorten_path = true,
    cwd = "~/.config/nvim",
    prompt = "~ config ~",
  }
end

return M
