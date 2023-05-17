return function(defaults)
  return vim.tbl_extend("force", defaults, {

    -- Pyright settings
    settings = {
      python = {
        analysis = {
          -- typeCheckingMode = "off",
          diagnosticMode = "openFilesOnly",
          diagnosticSeverityOverrides = {
            reportSelfClsParameterName = "none",
          },
        },
      },
    },

    -- Auto load VIRTUALENV
    before_init = function(_, config)
      if vim.env.VIRTUAL_ENV then
        config.settings.python.pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python"
      end
    end,
  })
end
