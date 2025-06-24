local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' --- %d lines'):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)

  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. ('.'):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'Comment' })
  vim.print(virtText, lnum, endLnum, width, truncate)
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "BufReadPost",
  config = function()
    local o = vim.o
    o.foldlevel = 99
    o.foldenable = true
    o.foldlevelstart = 99
    o.foldmethod = "expr"
    o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    require("ufo").setup({
      fold_virt_text_handler = handler,
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = { "imports", "comment" },
      },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
      },
    })
  end,
}
