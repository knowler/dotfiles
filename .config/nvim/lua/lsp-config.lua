local lspinstall = require'lspinstall'
lspinstall.setup()

local lsp = require'lspconfig'
local autocmd = require'utils'.autocmd

local prettier = {
  formatCommand = "./node_modules/.bin/prettier --config-precedence prefer-file --stdin-filepath ${INPUT}",
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

local efm_config = {
  init_options = {
    codeAction = true,
    documentFormatting = true,
  },
  root_dir = lsp.util.root_pattern("yarn.lock", ".git"),
  settings = {
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

local typescript_config = {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end,
  root_dir = lsp.util.root_pattern("yarn.lock", ".git"),
  settings = {
    documentFormatting = true,
  },
}

local function setup_servers()
  for _, server in pairs(lspinstall.installed_servers()) do
    local config = {}

    if server == "efm" then
      config = efm_config
    end

    if server == "typescript" then
      config = typescript_config
    end

    lsp[server].setup(config)
  end
end

setup_servers()

lspinstall.post_install_hook = function ()
  setup_servers()
  vim.cmd("bufdo e")
end

autocmd('formatting_sync', 'BufWritePost * silent! lua vim.lsp.buf.formatting()', true)
