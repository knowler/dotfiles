local utils = require'utils'
local opt = utils.opt
local cmd = vim.cmd

opt('t_Co', '256')
cmd [[if &term =~ '256color' | set t_ut= | endif]]
cmd [[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]]
opt('termguicolors', true)
cmd [[colorscheme iceberg]]
opt('background', 'dark')
cmd [[highlight NonText guibg=NONE ctermbg=NONE]]
cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
cmd [[highlight EndOfBuffer guibg=NONE ctermbg=NONE]]
cmd [[highlight LineNr guibg=NONE ctermbg=NONE]]
