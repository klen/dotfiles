local tools = require "tools"

require("mini.sessions").setup {
  autoread = false,
  autowrite = true,
}

tools.lua_command("-nargs=1 SessionRead", "MiniSessions.read(vim.fn.expand('<args>'))")
tools.lua_command("-nargs=1 SessionWrite", "MiniSessions.write(vim.fn.expand('<args>'))")
tools.lua_command("-nargs=0 SessionRestore", "MiniSessions.read(MiniSessions.get_latest())")
