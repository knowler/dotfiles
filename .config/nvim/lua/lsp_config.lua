local lsp = require'lspconfig'

lsp.vimls.setup{}
lsp.sumneko_lua.setup{}
lsp.tsserver.setup{}
--lsp.rome.setup{}
lsp.jsonls.setup{}
lsp.cssls.setup{}
lsp.bashls.setup{}
lsp.intelephense.setup{}
lsp.html.setup{}

-- Diagnostics (i.e. ESLint, Prettier, etc.)
lsp.diagnosticls.setup{
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  init_options = {
    linters = {
      eslint = {
        command = "yarn eslint",
        args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
        rootPatterns = { ".git" },
        sourceName = "eslint",
        debounce = 100,
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "[eslint] ${message} [${ruleId}]",
          security = "severity",
        },
      },
    },
    filetypes = {
      javascript = "eslint",
      javascriptreact = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
    },
    formatters = {
      prettier = {
        command = "yarn prettier",
        args = { "--stdin-filepath", "%filename" },
      },
    },
    formatFiletypes = {
      javascript = "prettier",
      javascriptreact = "prettier",
      json = "prettier",
    },
  },
}
