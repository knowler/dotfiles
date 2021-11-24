local lspinstall = require'lspinstall'
lspinstall.setup()

local lsp = require'lspconfig'
local autocmd = require'utils'.autocmd

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local textConfig = {
  filetypes = {'text', 'markdown', 'vimwiki', 'tex'},
}

local null_ls = require("null-ls")
null_ls.config({
    sources = {
        --null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.hover.dictionary.with(textConfig),
        null_ls.builtins.diagnostics.write_good.with(textConfig),
        null_ls.builtins.diagnostics.proselint.with(textConfig),
        null_ls.builtins.hover.dictionary.with(textConfig),
        --null_ls.builtins.diagnostics.markdownlint.with(textConfig),
        null_ls.builtins.diagnostics.misspell.with(textConfig),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.phpcbf.with({
          extra_args = {"--standard=PSR12"},
        }),
        null_ls.builtins.diagnostics.phpcs.with({
          extra_args = {
            "--standard=PSR12",
            "--runtime-set", "testVersion", "5.6-",
          },
        }),
    },
})

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  if client.resolved_capabilities.document_formatting then
    autocmd('formatting_sync', 'BufWritePost * silent! lua vim.lsp.buf.formatting()', true)
  end

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
end

local function setup_servers()
  for _, server in pairs(lspinstall.installed_servers()) do
    local config = {on_attach = on_attach}

    if server == "json" then
      config.settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      }
    end

    if server == "typescript" then
      --config = typescript
      --config.filetypes = {"javascript", "javascriptreact", "javascript.jsx"}
      config.init_options = require("nvim-lsp-ts-utils").init_options
      config.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach = function(client, bufnr)
          local ts_utils = require("nvim-lsp-ts-utils")

          -- defaults
          ts_utils.setup({
            debug = true,
            disable_commands = false,
            enable_import_on_completion = false,

            enable_formatting = true,
            formatter = 'prettier_d_slim',

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers = higher priority
            import_all_priorities = {
              same_file = 1, -- add to existing import statement
              local_files = 2, -- git files or files with relative path markers
              buffer_content = 3, -- loaded buffer content
              buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},

            -- inlay hints
            auto_inlay_hints = true,
            inlay_hints_highlight = "Comment",

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,
          })

          -- required to fix code action ranges and filter diagnostics
          ts_utils.setup_client(client)

          local opts = { silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", ":TSLspImportAll<CR>", opts)
        end
      end
    end

    if server == "lua" then
      config = {
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'},
            }
          }
        }
      }
    end

    if server == "php" then
      config = {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          on_attach(client, bufnr)
        end,
        init_options =  {
          documentFormatting = false,
        },
        settings = {
          documentFormatting = false,
          intelephense = {
            format = {
              enable = false,
            },
            environment = {
              phpVersion = "5.6"
            },
            stubs = { "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "phpunit", "pgsql", "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "wordpress", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib" }
          },
        },
      }
    end

    lsp[server].setup(config)
  end

  lsp["null-ls"].setup({on_attach = on_attach})
end

setup_servers()

lspinstall.post_install_hook = function ()
  setup_servers()
  vim.cmd("bufdo e")
end
