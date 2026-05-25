return {
  enabled = true,
  size = 5 * 1024 * 1024,        -- 5 MiB
  line_length = 5 * 1024 * 1024, -- 5 KiB
  setup = function(ctx)
    vim.cmd("syntax clear")
    vim.treesitter.stop(ctx.buf)
    vim.wo[0].foldmethod = "manual"
    vim.wo[0].foldexpr = ""

    -- Disable LSP features that are expensive on large files
    vim.schedule(function()
      vim.lsp.inlay_hint.enable(false, { bufnr = ctx.buf })
      vim.lsp.document_color.enable(false, { bufnr = ctx.buf })
    end)

    -- Keep diagnostics off for huge files
    vim.diagnostic.enable(false, { bufnr = ctx.buf })

    -- Disable indent guides
    vim.b[ctx.buf].snacks_indent = false
  end
}
