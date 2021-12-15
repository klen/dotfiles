return function(defaults)
  local ok, luadev = pcall(require, "lua-dev")
  if not ok then
    return defaults
  end

  return vim.tbl_extend("force", defaults, luadev.setup())
end
