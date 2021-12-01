return function()
  g["test#strategy"] = "neovim"
  g["test#neovim#term_position"] = "vert"
  g["test#python#runner"] = "pytest"
  g["test#python#pytest#file_pattern"] = "\\v^test.*\\.py$"
end
