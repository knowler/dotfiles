local lsp = require'lspconfig'

return {
  root_dir = lsp.util.root_pattern("yarn.lock", ".git"),
  settings = { documentFormatting = false },
}
