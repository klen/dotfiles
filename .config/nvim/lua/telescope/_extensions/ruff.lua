local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"

local config = { cmd = "ruff", args = { "." } }

local setup = function(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
end

local make_entry = function()
  return function(line)
    if line == nil then
      return nil
    end

    local displayer = entry_display.create {
      separator = " ",
      items = {
        { remaining = true },
        { width = 4 },
        { remaining = true },
      },
    }

    local function make_display(entry)
      local display_columns = {
        { entry.value.filename, "TelescopePreviewDirectory" },
        { entry.value.lnum, "TelescopeResultsComment" },
        { entry.value.display, "TelescopePreviewNormal" },
      }
      return displayer(display_columns)
    end

    local value = {}
    value.filename, value.lnum, value.col, value.display =
      string.match(line, "([^:]+):([^:]+):([^:]+): +(.+)$")

    if value.filename == nil then
      return nil
    end

    return {
      value = value,
      ordinal = line,
      display = make_display,
      filename = value.filename,
      lnum = tonumber(value.lnum),
      col = tonumber(value.col),
    }
  end
end

-- our picker function: colors
local run = function(opts)
  opts = opts or { buf = "cur" }
  opts.entry_maker = make_entry()

  pickers
    .new(opts, {
      prompt_title = "Ruff results",
      finder = finders.new_oneshot_job({ config.cmd, unpack(config.args) }, opts),
      sorter = conf.file_sorter(opts),
      previewer = conf.qflist_previewer(opts),
    })
    :find()
end

-- register_extension
return require("telescope").register_extension {
  setup = setup,
  exports = {
    ruff = run,
  },
}
