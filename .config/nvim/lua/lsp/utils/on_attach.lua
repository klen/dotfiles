require "tools/table"

local utils = require "lsp.utils"
local lsp = vim.lsp

return function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local maps = {
    ["K"] = { lsp.buf.hover, "Show documentation" },
    ["gr"] = { lsp.buf.references, "Find references" },
    ["gd"] = { lsp.buf.definition, "Go to definition" },
    ["<space>gd"] = {
      "<cmd>abo split | lua vim.lsp.buf.definition()<cr>",
      "Go to definition (split)",
    },
    ["<C-p>"] = { vim.diagnostic.goto_prev, "Jump to the previous error" },
    ["<C-n>"] = { vim.diagnostic.goto_next, "Jump to the next error" },

    ["gt"] = { lsp.buf.type_definition, "Go to type definition" },
    ["gi"] = { lsp.buf.implementation, "Go to implementation" },
    ["gl"] = { lsp.buf.declaration, "Go to declaration" },
    ["gs"] = { lsp.buf.signature_help, "Show signature help" },
    ["ge"] = { vim.diagnostic.open_float, "Show line error" },
    ["<space>r"] = { lsp.buf.rename, "Refactoring/Rename" },
    ["<space>a"] = { lsp.buf.code_action, "Run a code action" },
    ["<space>f"] = { lsp.buf.formatting, "Format code" },
    ["<space>q"] = { vim.diagnostic.setqflist, "Fill quickfix list" },
    ["<space>wa"] = { lsp.add_workspace_folder, "Add workspace folder" },
    ["<space>wr"] = { lsp.remove_workspace_folder, "Remove workspace folder" },
    ["<space>s"] = { lsp.buf.workspace_symbol, "Search symbol in workspace" },
    ["<space>S"] = { lsp.buf.document_symbol, "Search symbol in document" },
    ["<space>i"] = { lsp.buf.incoming_calls, "Show incomming calls" },
    ["<space>o"] = { lsp.buf.outgoing_calls, "Show outgoing calls" },
    ["<space>wl"] = {
      function()
        vim.print(lsp.buf.list_workspace_folders())
      end,
      "List workspace folders",
    },
    ["<space>c"] = {
      function()
        vim.print(client.config)
      end,
      "Show client config",
    },
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
  -- vim.api.nvim_create_autocmd("cursorholdi", { pattern = "*", callback = lsp.buf.signature_help })

  -- Code actions
  vim.keymap.set("v", "<space>a", lsp.buf.code_action, { buffer = bufnr })

  -- Formatting
  vim.api.nvim_create_user_command("Format", function(args)
    utils.format(args.line1, args.line2)
  end, { range = true })

  -- Auto format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd(
      "BufWritePre",
      { pattern = "<buffer>", callback = utils.formatOnSave }
    )
  end

  ---@diagnostic disable-next-line: redefined-local
  local ok, lsp_status = pcall(require, "lsp-status")
  if ok then
    lsp_status.on_attach(client)
  end
end
