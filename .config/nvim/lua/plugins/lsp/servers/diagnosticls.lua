local file_types = {
  ["javascript"] = {
    linter = require "diagnosticls-configs.linters.eslint",
    formatter = require "diagnosticls-configs.formatters.prettier",
  },
  ["javascriptreact"] = {
    linter = require "diagnosticls-configs.linters.eslint",
    formatter = require "diagnosticls-configs.formatters.prettier",
  },
  ["python"] = {
    linter = require "diagnosticls-configs.linters.flake8",
    formatter = require "diagnosticls-configs.formatters.black",
  },
  ["typescriptreact"] = {
    linter = require "diagnosticls-configs.linters.eslint",
    formatter = require "diagnosticls-configs.formatters.prettier",
  },
}

return function(_)
  local config = {
    root_dir = require("lspconfig").util.root_pattern ".git",
    default_config = false,
    format = true,
    filetypes = {},
    init_options = {
      filetypes = {},
      formatFiletypes = {},
      linters = {},
      formatters = {},
    },
  }

  for filetype, config_types in pairs(file_types) do
    table.insert(config.filetypes, filetype)
    for config_type, cfg in pairs(config_types) do
      if config_type == "linter" then
        if vim.tbl_islist(cfg) then
          local sources = {}
          for _, config_source in pairs(cfg) do
            local source_name = config_source["sourceName"]
            table.insert(sources, source_name)
            config.init_options.linters[source_name] = config_source
          end
        else
          local source_name = cfg["sourceName"]
          config.init_options.linters[source_name] = cfg
          config.init_options.filetypes[filetype] = source_name
        end
      end
      if config_type == "formatter" then
        if vim.tbl_islist(cfg) then
          local sources = {}
          for _, config_source in pairs(cfg) do
            local source_name = config_source["sourceName"]
            table.insert(sources, source_name)
            config.init_options.formatters[source_name] = config_source
          end
        else
          local source_name = cfg["sourceName"]
          config.init_options.formatters[source_name] = cfg
          config.init_options.formatFiletypes[filetype] = source_name
        end
      end
    end
  end

  return config
end
