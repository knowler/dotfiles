require'nvim-treesitter.configs'.setup{
  -- Parsers
  ensure_installed = "maintained",

  -- Modules
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "gnU",
        goto_previous_usage = "gpU",
      },
    },
    smart_rename = { enable = true },
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
}
