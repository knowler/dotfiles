local cmd = vim.cmd
local opt = vim.opt

vim.g.t_Co = 256
cmd [[if &term =~ '256color' | set t_ut= | endif]]
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
opt.termguicolors = true
cmd [[colorscheme iceberg]]
opt.background = 'dark'

local highlights = {
  'NonText',
  'Normal',
  'EndOfBuffer',
  'LineNr',
}

for _, highlight in ipairs(highlights) do
  vim.api.nvim_set_hl(
    0,
    highlight,
    vim.tbl_extend(
      'force',
      vim.api.nvim_get_hl_by_name(highlight, true),
      {background = 'NONE'}
    )
  )
end

cmd [[let g:lightline = {'colorscheme': 'iceberg'}]]
