_G.api = vim.api
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.g = vim.g
_G.lsp = vim.lsp

_G.printt = function(...)
  print(unpack(vim.tbl_map(vim.inspect, { ... })))
end

-- Table functions

function table.is_table(t)
  return type(t) == "table"
end

function table.pop(t, key)
  if not table.is_table(t) then
    return nil
  end
  local value = t[key]
  t[key] = nil
  return value
end

function table.contains(t, value)
  if not table.is_table(t) then
    return nil
  end
  for _, v in ipairs(t) do
    if value == v then
      return true
    end
  end
  return false
end

function table.reverse(t)
  if not table.is_table(t) then
    return nil
  end
  for idx = 1, math.floor(#t / 2) do
    t[idx], t[#t - idx + 1] = t[#t - idx + 1], t[idx]
  end
  return t
end