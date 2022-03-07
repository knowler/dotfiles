local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local null_ls = require("null-ls")
local autocmd = require'utils'.autocmd

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  'tsserver',
  'denols',
  'cssls',
  'sumneko_lua',
  'rust_analyzer',
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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

lsp_installer.on_server_ready(function(server)
  local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local server_opts = {
    ['tsserver'] = function()
      --If this is Deno then bail out.
      if lspconfig.util.root_pattern('deno.json')('.') then
        default_opts.filetypes = {}
      end

      default_opts.root_dir = lspconfig.util.root_pattern('package.json')

      default_opts.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
      end
      default_opts.settings = {
        format = {
          enable = false,
        },
      }
    end,
    ['denols'] = function()
      --If this is Node then bail out.
      if lspconfig.util.root_pattern('package.json')('.') then
        default_opts.filetypes = {}
      end
    end,
    ['jsonls'] = function ()
      default_opts.init_options = {
          documentFormatting = false,
      }
      default_opts.settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
        init_options = {
          documentFormatting = false,
          provideFormatter = false,
        },
        format = {
          enable = false,
        },
      }
    end,
    ['sumneko_lua'] = function ()
      default_opts.settings = {
        Lua = {
          diagnostics = {
            globals = {'vim'},
          },
        },
      }
    end,
  }

  server:setup(
    server_opts[server.name] and server_opts[server.name]() or default_opts
  )
end)

null_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
    }),
  },
})
