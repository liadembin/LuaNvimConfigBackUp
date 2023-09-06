local llm = require('llm')

llm.setup({
  api_token = nil, -- cf Install paragraph
  query_params = {
    stop_token = "<EOT>",
  },
  fim = {
    enabled = true,
    prefix = "<PRE> ",
    middle = " <MID>",
    suffix = " <SUF>",
  },
  model = "codellama/CodeLlama-13b-hf",
  context_window = 4096,
  debounce_ms = 150,
  accept_keymap = "<Tab>",
  dismiss_keymap = "<S-Tab>",
  max_context_after = 5000,
  max_context_before = 5000,
  tls_skip_verify_insecure = false,
  -- llm-ls integration
  lsp = {
    enabled = false,
    bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/llm_nvim/bin/llm-ls",
  },
  tokenizer_path = nil, -- when setting model as a URL, set this var
})
