return function(client, bufnr)
  local u = require "utils"

  -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --
  local maps = {
    ["K"] = { "<cmd>lua lsp.buf.hover()<cr>", "Show documentation" },
    ["gr"] = { "<cmd>lua lsp.buf.references()<cr>", "Find references" },
    ["gd"] = { "<cmd>lua lsp.buf.definition()<cr>", "Go to definition" },
    ["<space>gd"] = { "<cmd>to split | lua lsp.buf.definition()<cr>", "Go to definition (split)" },
    ["gi"] = { "<cmd>lua lsp.buf.implementation()<cr>", "Go to implementation" },
    ["gD"] = { "<cmd>lua lsp.buf.declaration()<cr>", "Go to declaration" },
    ["gt"] = { "<cmd>lua lsp.buf.type_definition()<cr>", "Go to type definition" },
    ["gs"] = { "<cmd>lua lsp.buf.signature_help()<cr>", "Show signature help" },
    -- ['ge'] = '<cmd>lua lsp.diagnostic.show_line_diagnostics()<cr>',
    ["ge"] = {
      "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>",
      "Show line error",
    },
    -- ['[d'] = "<cmd>lua lsp.diagnostic.goto_prev()<cr>",
    ["[d"] = {
      "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>",
      "Jump to the previous error",
    },
    -- ['[d'] = "<cmd>lua lsp.diagnostic.goto_next()<cr>",
    ["]d"] = {
      "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>",
      "Jump to the next error",
    },
    -- ['<space>r'] = '<cmd>lua lsp.buf.rename()<cr>',
    ["<space>r"] = { "<cmd>Lspsaga rename<cr>", "Refactoring/Rename" },
    -- ['<space>a'] = "<cmd>lua lsp.buf.code_action()<cr>",
    ["<space>a"] = {
      "<cmd>lua require'lspsaga.codeaction'.code_action()<cr>",
      "Run a code action",
    },
    ["<space>f"] = { "<cmd>lua lsp.buf.formatting()<cr>", "Format code" },
    ["<space>q"] = { "<cmd>lua lsp.diagnostic.set_loclist()<cr>", "Fill location list" },
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
      u.nmap(target, source[1], { bufnr = bufnr })
    end
  end

  -- Signature Help
  -- u.au("cursorholdi", "*", "Lspsaga signature_help")

  -- Code actions
  -- u.vmap("<space>a", "<cmd>lua lsp.buf.range_code_action()<CR>", {bufnr=bufnr})
  u.vmap(
    "<space>a",
    "<cmd>lua require'lspsaga.codeaction'.range_code_action()<cr>",
    { bufnr = bufnr }
  )

  -- Formatting
  u.lua_command("Format", "lsp.buf.formatting()")

  if client.resolved_capabilities.document_range_formatting then
    u.vmap("<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", { bufnr = bufnr })
  end

  if client.resolved_capabilities.document_formatting then
    u.au("BufWritePre", "<buffer>", "lua require('utils.lsp').formatOnSave()")
  end
end
