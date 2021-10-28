local lspinstall = require'lspinstall'
lspinstall.setup()

local lsp = require'lspconfig'
local configs = require'lspconfig/configs'
local autocmd = require'utils'.autocmd

local efm = require'lsp.efm'
local typescript = require'lsp.typescript'
local inferPhpVersion = require'php-version'.inferPhpVersion

if not lsp.psalmls then
  configs.psalmls = {
    default_config = {
      cmd = {'./vendor/bin/psalm-language-server'},
      root_dir = lsp.util.root_pattern("psalm.xml", "psalm.xml.dist"),
      filetypes = {'php'},
      settings = {},
    }
  }
end

lsp.psalmls.setup{}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lsp.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css'};
      root_dir = function()
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
lsp.emmet_ls.setup{ capabilities = capabilities; }

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

    if server == "efm" then
      config = efm
      config.on_attach = on_attach
    end

    if server == "typescript" then
      config = typescript
      config.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
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
              phpVersion = inferPhpVersion(),
            },
            stubs = { "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "phpunit", "pgsql", "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "wordpress", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib" }
          },
        },
      }
    end

    lsp[server].setup(config)
  end
end

setup_servers()

lspinstall.post_install_hook = function ()
  setup_servers()
  vim.cmd("bufdo e")
end
