require "tools/table"

local utils = require "lsp.utils"
local lsp = vim.lsp

return function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local maps = {
    {
      "gr",
      lsp.buf.references,
      desc = "Find references",
    },
    {
      "gd",
      lsp.buf.definition,
      desc = "Go to definition",
    },
    {
      "<space>gd",
      "<cmd>abo split | lua vim.lsp.buf.definition()<cr>",
      desc = "Go to definition (split)",
    },
    {
      "<C-p>",
      function()
        vim.diagnostic.jump { count = -1, float = true }
      end,
      desc = "Jump to the previous error",
    },
    {
      "<C-n>",
      function()
        vim.diagnostic.jump { count = 1, float = true }
      end,
      desc = "Jump to the next error",
    },
    {
      "gt",
      lsp.buf.type_definition,
      desc = "Go to type definition",
    },
    {
      "gi",
      lsp.buf.implementation,
      desc = "Go to implementation",
    },
    {
      "gl",
      lsp.buf.declaration,
      desc = "Go to declaration",
    },
    {
      "gs",
      lsp.buf.signature_help,
      desc = "Show signature help",
    },
    {
      "ge",
      vim.diagnostic.open_float,
      desc = "Show line error",
    },
    {
      "<space>r",
      lsp.buf.rename,
      desc = "Refactoring/Rename",
    },
    {
      "<space>a",
      lsp.buf.code_action,
      desc = "Run a code action",
    },
    {
      "<space>f",
      lsp.buf.formatting,
      desc = "Format code",
    },
    {
      "<space>q",
      vim.diagnostic.setqflist,
      desc = "Fill quickfix list",
    },
    {
      "<space>wa",
      lsp.add_workspace_folder,
      desc = "Add workspace folder",
    },
    {
      "<space>wr",
      lsp.remove_workspace_folder,
      desc = "Remove workspace folder",
    },
    {
      "<space>s",
      lsp.buf.workspace_symbol,
      desc = "Search symbol in workspace",
    },
    {
      "<space>S",
      lsp.buf.document_symbol,
      desc = "Search symbol in document",
    },
    {
      "<space>i",
      lsp.buf.incoming_calls,
      desc = "Show incomming calls",
    },
    {
      "<space>o",
      lsp.buf.outgoing_calls,
      desc = "Show outgoing calls",
    },
    {
      "<space>wl",
      function()
        vim.print(lsp.buf.list_workspace_folders())
      end,
      desc = "List workspace folders",
    },
    {
      "<space>c",
      function()
        vim.print(client.config)
      end,
      desc = "Show client config",
    },
    { "<space>",  group = "lsp" },
    { "<space>w", group = "workspace" },
  }

  -- Hover
  if client.server_capabilities.hoverProvider then
    table.insert(maps, {
      "K",
      lsp.buf.hover,
      desc = "Show documentation",
    })
  end

  local ok, wk = pcall(require, "which-key")
  if ok then
    -- Map with wk
    wk.add(maps, { buffer = bufnr })
  else
    -- Map keys in normal mode
    for _, map in ipairs(maps) do
      vim.keymap.set("n", map[1], map[2], { buffer = bufnr })
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
  if client.server_capabilities.documentFormattingProvider and client.config.format then
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
