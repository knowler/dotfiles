local lsp = require'lspconfig'
local autocmd = require'utils'.autocmd

local prettier = { 
  formatCommand = "./node_modules/bin/prettier --config-precedence prefer-file --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true,
}

local phpcs = {
  formatCommand = "./vendor/bin/phpcs --stdin-path=${INPUT} -",
  formatStdin = true,
}

lsp.cssls.setup {}
--lsp.denols.setup {}
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
      php = {phpcs},
    },
    log_level = 1,
    log_file = "~/efm.log",
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'php',
  },
}
lsp.html.setup {}
lsp.intelephense.setup {}
lsp.jsonls.setup {}
lsp.sumneko_lua.setup {}
lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end,
  settings = {
    documentFormatting = false,
  },
}
lsp.vimls.setup {}

autocmd('formatting_sync', 'BufWritePost * silent! lua vim.lsp.buf.formatting()', true)
