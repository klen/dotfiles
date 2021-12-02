return function()
  local wk = require "which-key"

  wk.setup {
    operators = {
      gc = "Comments",
      ys = "Surround",
      Q = "Format",
    },
  }
end
