vim.opt.showtabline = 1 -- Show tabline only when there are at least two tabs
vim.opt.tabline = "%!v:lua.tabline()"

function _G.tabline()
  local tabs = vim.api.nvim_list_tabpages()
  local current = vim.api.nvim_get_current_tabpage()

  local t = ""

  for i, tab in ipairs(tabs) do
    local is_active = tab == current

    local win = vim.api.nvim_tabpage_get_win(tab)
    local bufnr = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local name = vim.fn.fnamemodify(bufname, ":t")

    if name == "" then
      name = "[no name]"
    end

    local hl = is_active and "%#TabLineSel#" or "%#TabLine#"

    t = t .. "%" .. i .. "T" .. hl .. " " .. i .. ":" .. name .. "  "
  end

  return t .. "%#TabLineFill#%T%="
end
