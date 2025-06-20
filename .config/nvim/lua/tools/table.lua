-- Table utility functions

--- Checks if the given variable is a table.
-- @param t any: The variable to check.
-- @return boolean: True if `t` is a table, false otherwise.
function table.is_table(t)
  return type(t) == "table"
end

--- Removes and returns a value from a table by its key.
-- @param t table: The table to modify.
-- @param key any: The key of the value to pop.
-- @return any: The value associated with the key, or nil if the table is invalid or the key doesn't exist.
function table.pop(t, key)
  if not table.is_table(t) then
    return nil
  end
  local value = t[key]
  t[key] = nil -- Remove the key-value pair
  return value
end

--- Checks if a table (specifically an array-like table) contains a given value.
-- Note: This performs a linear search and is suitable for smaller tables.
-- @param t table: The table to search within.
-- @param value any: The value to look for.
-- @return boolean: True if the value is found, false otherwise. Returns nil if `t` is not a table.
function table.contains(t, value)
  if not table.is_table(t) then
    return nil
  end
  for _, v in ipairs(t) do -- Iterate through numeric indices
    if value == v then
      return true
    end
  end
  return false
end

--- Reverses the order of elements in an array-like table in-place.
-- @param t table: The table to reverse.
-- @return table: The reversed table itself. Returns nil if `t` is not a table.
function table.reverse(t)
  if not table.is_table(t) then
    return nil
  end
  -- Iterate only up to the middle of the table to avoid reversing twice
  for idx = 1, math.floor(#t / 2) do
    -- Swap elements from start and end
    t[idx], t[#t - idx + 1] = t[#t - idx + 1], t[idx]
  end
  return t
end

--- Retrieves a nested value from a table using a dot-separated path.
-- @param tbl table: The table to search within.
-- @param path string: The dot-separated path to the desired value (e.g., "level1.level2.key").
-- @param default any: (Optional) The default value to return if the path is not found.
-- @return any: The value found at the specified path, or the `default` value if any part of the path is invalid or not found.
function table.get(tbl, path, default)
  local value = tbl
  -- Iterate through each part of the path
  for part in string.gmatch(path, "[^%.]+") do
    if table.is_table(value) and value[part] ~= nil then
      value = value[part]
    else
      -- If `value` is not a table at any point, or `part` does not exist, return default.
      return default
    end
  end
  return value
end

return table -- Export the table module
