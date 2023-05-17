require "tools/table"

local cfg = require "config"
local utils = require "plugins.lsp.utils"
local api = vim.api
local lsp = vim.lsp

return function(client, bufnr)
  local params = cfg.lsp.servers[client.name] or {}

  -- Tune capabilities
  if params.capabilities then
    client.server_capabilities =
      vim.tbl_extend("force", client.server_capabilities, params.capabilities)
  end

  -- Tune diagnostic
  if params.diagnostic then
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    vim.diagnostic.config(params.diagnostic, ns)
  end

  -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local maps = {
    ["K"] = { lsp.buf.hover, "Show documentation" },
    ["gr"] = { lsp.buf.references, "Find references" },
    ["gd"] = { lsp.buf.definition, "Go to definition" },
    ["<space>gd"] = {
      "<cmd>abo split | lua vim.lsp.buf.definition()<cr>",
      "Go to definition (split)",
    },
    ["gi"] = { lsp.buf.implementation, "Go to implementation" },
    ["gl"] = { lsp.buf.declaration, "Go to declaration" },
    ["gt"] = { lsp.buf.type_definition, "Go to type definition" },
    ["gs"] = { lsp.buf.signature_help, "Show signature help" },
    ["ge"] = { vim.diagnostic.open_float, "Show line error" },
    ["<C-p>"] = { vim.diagnostic.goto_prev, "Jump to the previous error" },
    ["<C-n>"] = { vim.diagnostic.goto_next, "Jump to the next error" },
    ["<space>r"] = { lsp.buf.rename, "Refactoring/Rename" },
    ["<space>a"] = { lsp.buf.code_action, "Run a code action" },
    ["<space>f"] = { lsp.buf.formatting, "Format code" },
    ["<space>q"] = { vim.diagnostic.set_loclist, "Fill location list" },
    ["<space>wa"] = { lsp.add_workspace_folder, "Add workspace folder" },
    ["<space>wr"] = { lsp.remove_workspace_folder, "Remove workspace folder" },
    ["<space>wl"] = {
      function()
        vim.print(lsp.buf.list_workspace_folders())
      end,
      "List workspace folders",
    },
    ["<space>s"] = { lsp.buf.workspace_symbol, "Search symbol in workspace" },
    ["<space>S"] = { lsp.buf.document_symbol, "Search symbol in document" },
    ["<space>i"] = { lsp.buf.incoming_calls, "Show incomming calls" },
    ["<space>o"] = { lsp.buf.outgoing_calls, "Show outgoing calls" },
  }

  -- Hover
  if not client.server_capabilities.hoverProvider then
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
      vim.keymap.set("n", target, source[1], { buffer = bufnr })
    end
  end

  -- Signature Help
  vim.keymap.set({ "i", "n" }, "<C-s>", lsp.buf.signature_help, { buffer = bufnr })
  -- api.nvim_create_autocmd("cursorholdi", { pattern = "*", callback = lsp.buf.signature_help })

  -- Code actions
  vim.keymap.set("v", "<space>a", lsp.buf.code_action, { buffer = bufnr })

  -- Formatting
  api.nvim_create_user_command("Format", function(args)
    utils.format(args.line1, args.line2)
  end, { range = true })

  -- Auto format on save
  local format_on_save = params.format_on_save
  if format_on_save == nil then
    format_on_save = cfg.lsp.format_on_save
  end
  if client.server_capabilities.documentFormattingProvider and format_on_save then
    api.nvim_create_autocmd("BufWritePre", { pattern = "<buffer>", callback = utils.formatOnSave })
  end

  ---@diagnostic disable-next-line: redefined-local
  local ok, lsp_status = pcall(require, "lsp-status")
  if ok then
    lsp_status.on_attach(client)
  end
end
