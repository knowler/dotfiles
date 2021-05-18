require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    'bash', 
    'bibtex', 
    --'comment', 
    'css', 
    'graphql',
    'html', 
    'javascript', 
    --'jsdoc', 
    'json', 
    'jsonc', 
    'latex', 
    'lua', 
    'php', 
    'swift',
    'toml', 
    --'tsx', 
    --'typescript', 
    'yaml', 
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  autotag = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grr',
      },
    }
  },
}
