local starter = require('mini.starter')
local new_section = function(name, action, section)
  return { name = name, action = action, section = section or "Actions" }
end
local picker = require('snacks.picker')


starter.setup {
  content_hooks = {
    starter.gen_hook.adding_bullet(),              -- Adds a bullet point before each item
    starter.gen_hook.aligning("center", "center"), -- Centers content both horizontally and vertically
  },
  items = {
    -- Recent files
    starter.sections.recent_files(5, true),
    new_section("New file", "ene | startinsert"),
    new_section("Find file", picker.files),
    new_section("Find text", picker.grep),
    new_section("Quit", "qa"),
  },
  header = function()
    local hour = tonumber(vim.fn.strftime("%H"))
    -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
    local part_id = math.floor((hour + 4) / 8) + 1
    local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
    local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

    local fortune = vim.fn.system("fortune -s 2>/dev/null"):gsub("%s+$", "")
    return ("Good %s, %s!"):format(day_part, username) .. "\n\n" .. (fortune or "Welcome to Neovim!")
  end,
}
