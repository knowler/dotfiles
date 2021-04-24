local lsp = require'lspconfig'

local prettier = { 
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local eslint = {
  lintCommand = "eslint -f unix --stdin --stdin-filepath ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}

lsp.cssls.setup {}
lsp.efm.setup {
  init_options = {
    codeAction = true,
    documentFormatting = true,
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      javascript = {prettier, eslint},
      javascriptreact = {prettier, eslint},
      ['javascript.jsx'] = {prettier, eslint},
    },
    log_level = 1,
    log_file = "~/efm.log",
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
  },
  on_attach = on_attach,
}
lsp.html.setup {}
lsp.intelephense.setup {}
lsp.jsonls.setup {}
lsp.sumneko_lua.setup {}
lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end,
  settings = {documentFormatting = false},
}
lsp.vimls.setup {}
