local lsp = require'lspconfig'

local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true,
}

local prettier = {
  formatCommand = "./node_modules/.bin/prettier --config-precedence prefer-file --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local phpcs = {
  lintCommand = './vendor/bin/phpcs --report=emacs',
  lintFormats = {'%f:%l:%c: %trror - %m', '%f:%l:%c: %tarning - %m'}
}

local phpcbf = {
  formatCommand = './vendor/bin/phpcbf --stdin-path=${INPUT} -',
  formatStdin = true,
}

local languages = {
  javascript = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  ['javascript.jsx'] = {prettier, eslint},
  php = {phpcs, phpcbf},
}

return {
  init_options = {
    codeAction = true,
    documentFormatting = true,
  },
  root_dir = lsp.util.root_pattern("composer.json", "package-lock.json", "yarn.lock", ".git"),
  filetypes = vim.tbl_keys(languages),
  settings = {
    languages = languages,
    log_level = 1,
    log_file = "~/efm.log",
  },
}

