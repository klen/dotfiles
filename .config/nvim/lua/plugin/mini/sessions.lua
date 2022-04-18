local create_user_command = vim.api.nvim_create_user_command

require("mini.sessions").setup {
  autoread = false,
  autowrite = true,
}

create_user_command("SessionRead", function(args)
  MiniSessions.read(args.args)
end, { nargs = 1 })
create_user_command("SessionWrite", function(args)
  MiniSessions.write(args.args)
end, { nargs = 1 })
create_user_command("SessionRestore", function()
  MiniSessions.read(MiniSessions.get_latest())
end, { nargs = 0 })
