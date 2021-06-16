require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    'bash',
    'bibtex',
    'css',
    'graphql',
    'html',
    'javascript',
    'json',
    'jsonc',
    'latex',
    'lua',
    'php',
    'swift',
    'toml',
    'yaml',
  },
  highlight = {
    enable = true,
    disable = {'php'}
  },
  indent = { enable = true },
  incremental_selection = { enable = true },
}
