local cfg = require "config"

return function(client, bufnr)
  local tools = require "tools"
  local params = cfg.lsp.servers[client.name]
  if params then
    client.resolved_capabilities = vim.tbl_extend("force", client.resolved_capabilities, params)
  end

  -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local maps = {
    ["K"] = { "<cmd>lua lsp.buf.hover()<cr>", "Show documentation" },
    ["gr"] = { "<cmd>lua lsp.buf.references()<cr>", "Find references" },
    ["gd"] = { "<cmd>lua lsp.buf.definition()<cr>", "Go to definition" },
    ["<space>gd"] = {
      "<cmd>abo split | lua lsp.buf.definition()<cr>",
      "Go to definition (split)",
    },
    ["gi"] = { "<cmd>lua lsp.buf.implementation()<cr>", "Go to implementation" },
    ["gl"] = { "<cmd>lua lsp.buf.declaration()<cr>", "Go to declaration" },
    ["gt"] = { "<cmd>lua lsp.buf.type_definition()<cr>", "Go to type definition" },
    ["gs"] = { "<cmd>lua lsp.buf.signature_help()<cr>", "Show signature help" },
    ["ge"] = {
      "<cmd>lua vim.diagnostic.open_float()<cr>",
      "Show line error",
    },
    ["<C-p>"] = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Jump to the previous error",
    },
    ["<C-n>"] = {
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      "Jump to the next error",
    },
    ["<space>r"] = {
      "<cmd>lua lsp.buf.rename()<cr>",
      "Refactoring/Rename",
    },
    ["<space>a"] = {
      "<cmd>lua lsp.buf.code_action()<cr>",
      "Run a code action",
    },
    ["<space>f"] = { "<cmd>lua lsp.buf.formatting()<cr>", "Format code" },
    ["<space>q"] = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Fill location list" },
    ["<space>wa"] = { "<cmd>lua lsp.add_workspace_folder()<cr>", "Add workspace folder" },
    ["<space>wr"] = { "<cmd>lua lsp.remove_workspace_folder()<cr>", "Remove workspace folder" },
    ["<space>wl"] = {
      "<cmd>lua print(vim.inspect(lsp.buf.list_workspace_folders()))<cr>",
      "List workspace folders",
    },
    ["<space>s"] = { "<cmd>lua lsp.buf.workspace_symbol()<cr>", "Search symbol in workspace" },
    ["<space>S"] = { "<cmd>lua lsp.buf.document_symbol()<cr>", "Search symbol in document" },
    ["<space>i"] = { "<cmd>lua lsp.buf.incoming_calls()<cr>", "Show incomming calls" },
    ["<space>o"] = { "<cmd>lua lsp.buf.outgoing_calls()<cr>", "Show outgoing calls" },
  }

  -- Hover
  if not client.resolved_capabilities.hover then
    table.pop(maps, "K")
  end

  local ok, wk = pcall(require, "which-key")
  if ok then
    -- Map with wk
    wk.register {
      ["<space>"] = { name = "+lsp" },
      ["<space>w"] = { name = "+workspace" },
    }
    wk.register(maps, { buffer = bufnr })
  else
    -- Map keys in normal mode
    for target, source in pairs(maps) do
      tools.nmap(target, source[1], { bufnr = bufnr })
    end
  end

  -- Signature Help
  -- tools.au("cursorholdi", "*", "lua lsp.buf.signature_help()")

  -- Code actions
  tools.vmap("<space>a", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", { bufnr = bufnr })

  -- Formatting
  tools.lua_command("Format", "lsp.buf.formatting()")

  if client.resolved_capabilities.document_range_formatting then
    tools.vmap("<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", { bufnr = bufnr })
  end

  -- Auto format on save
  if client.resolved_capabilities.document_formatting then
    tools.au("BufWritePre", "<buffer>", "lua require('plugin.lsp.utils').formatOnSave()")
  end

  ---@diagnostic disable-next-line: redefined-local
  local ok, lsp_status = pcall(require, "lsp-status")
  if ok then
    lsp_status.on_attach(client)
  end
end
