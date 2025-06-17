local common = {
  -- Backend
  backend = 'openai',
  url = 'http://localhost:1234/v1',

  -- Settings
  debounce_ms = 300,
  context_window = 8192,
  lsp = {
    bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
  },
  -- The settings are related only for ViViDboarder version
  keymap = {
    modes = { "i" },
    accept = "<C-j>",
    dismiss = "<C-o>"
  },
}

local models = {
  codegemma = {
    model = 'codegemma-2b',
    tokens_to_clear = { "<|file_separator|>" },
    fim = {
      enabled = true,
      prefix = "<|fim_prefix|>",
      middle = "<|fim_middle|>",
      suffix = "<|fim_suffix|>",
    },
    tokenizer = {
      repository = "google/codegemma-2b",
    }
  },
  deepseekcoder = {
    model = "deepseek-coder-v2-lite-instruct",
    fim = {
      enabled = true,
      prefix = '<｜fim▁begin｜>',
      suffix = '<｜fim▁hole｜>',
      middle = '<｜fim▁end｜>',
    },
    request_body = {
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },
  },
  qwencoder = {
    model = "qwen/qwen2.5-coder-14b",
    fim = {
      enabled = true,
      prefix = "<|fim_prefix|>",
      middle = "<|fim_middle|>",
      suffix = "<|fim_suffix|>",
    },
    tokenizer = {
      repository = "Qwen/Qwen2.5-Coder-7B-Instruct", -- Репозиторий токенизатора
    },
  }
}


return {
  -- TODO: huggingface version is quite outdated
  -- 'huggingface/llm.nvim',
  'ViViDboarder/llm.nvim',
  opts = vim.tbl_deep_extend("force", common, models.qwencoder),
}
