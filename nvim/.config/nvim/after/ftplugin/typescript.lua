local utils = require("utils")

vim.api.nvim_create_user_command("BiomeQF", function()
  utils.qf_from_cmd("Biome", "biome check --reporter github", "::%t%*[^,],file=%f,line=%l%*[^,],col=%c%*[^:]:%m")
end, {})

vim.api.nvim_create_user_command("TSQF", function()
  utils.qf_from_cmd(
    "typescript",
    "bun run tsc --noEmit --pretty false",
    -- file:line:column: type message
    -- __mocks__/fixtures/surveys.ts(71,10): error TS2678: Type '"scale10"' is not comparable
    "%f(%l\\,%c): %t%*[^:]: %m"
  )
end, {})
