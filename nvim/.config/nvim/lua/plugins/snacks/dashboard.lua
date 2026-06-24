local snacks = require("snacks")

vim.keymap.set("n", "<leader>dd", function() snacks.dashboard() end, { desc = "Open Dashboard" })

-- adaptive dashboard width based on available columns
local orig_open = snacks.dashboard.open
function snacks.dashboard.open(opts)
  opts = opts or {}
  opts.width = math.min(100, math.max(60, vim.o.columns - 8))
  local self = orig_open(opts)
  local orig_update = self.update
  function self.update()
    self.opts.width = math.min(120, math.max(60, vim.o.columns - 8))
    ---@diagnostic disable-next-line: redundant-parameter
    orig_update(self)
  end

  return self
end

return {
  enabled = true,
  sections = {
    -- Greet the user based on the time of day
    function()
      local hour = tonumber(vim.fn.strftime("%H"))
      -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
      local part_id = math.floor((hour + 4) / 8) + 1
      local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
      local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

      local header = ("Good %s, %s!"):format(day_part, username)
      return {
        title = { header, hl = "Bold" },
      }
    end,
    -- Recent files, sessions, and actions
    { title = { { "Recent Files", hl = "functioncall" } }, padding = { 1, 2 } },
    { section = "recent_files",                            indent = 2,        cwd = true },
    -- Projects section
    -- { title = { { "Sessions", hl = "functioncall" } },     padding = { 1, 2 } },
    -- { section = "projects",                                indent = 2, },
    { title = { { "Actions", hl = "functioncall" } },      padding = { 1, 2 } },
    { section = "keys",                                    indent = 2 },
    -- A random fortune cookie message
    function()
      local fortune = vim.fn.system("fortune -s 2>/dev/null"):gsub("%s+$", "") or 'Welcome to Neovim!'
      return {
        title = { fortune, hl = "Comment" },
        padding = { 0, 2 },
      }
    end,
  },
  formats = {
    icon = function() return { "", width = 0 } end,
    key = function(item)
      return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
    end,
    desc = function(item) return { { item.desc, hl = "Identifier" } } end,
    file = function(item, ctx)
      local fname = vim.fn.fnamemodify(item.file, ":~")
      local is_dir = vim.fn.isdirectory(item.file) == 1
      fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
      if #fname > ctx.width then
        local dir = vim.fn.fnamemodify(fname, ":h")
        local file = vim.fn.fnamemodify(fname, ":t")
        if dir and file then
          file = file:sub(-(ctx.width - #dir - 2))
          fname = dir .. "/…" .. file
        end
      end
      local dir, file = fname:match("^(.*)/(.+)$")
      local file_hl = is_dir and "directory" or "Text"
      return dir and { { dir .. "/", hl = "directory" }, { file, hl = file_hl } } or { { fname, hl = file_hl } }
    end,
  }
}
