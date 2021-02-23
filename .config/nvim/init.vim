" Plugins like this
set nocompatible

" Use vim-plug for plugin management (install first)
" install with :PlugInstall
" update with :PlugUpdate
call plug#begin(stdpath('data') . '/plugged')

" Essentials
Plug 'sheerun/vim-polyglot'                           " The only syntax highlighting package you will ever need
Plug 'AndrewRadev/splitjoin.vim'                      " Easily switch between single and multi line format for stuff (split: gS | join: gJ)
Plug 'tpope/vim-fugitive'                             " Git for vim
Plug 'tpope/vim-surround'                             " Surround stuff
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " Fuzzy find stuff
Plug 'junegunn/fzf.vim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " LSP aka Intellisense for vim (extensions are installed with :CocInstall)
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-actions', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-svg', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}


" Tmux essentials
Plug 'christoomey/vim-tmux-navigator'

" Cosmetic
Plug 'cocopon/iceberg.vim'
Plug 'cocopon/colorswatch.vim'

" Helpful cosmetic
Plug 'airblade/vim-gitgutter'                         " Show git status for lines in gutter
Plug 'vim-airline/vim-airline'

" Helpful
Plug 'junegunn/vim-slash'                             " Automatically clears search highlight when cursor is moved (and more)
Plug 'junegunn/vim-peekaboo'                          " Show the contents of registers
Plug 'Raimondi/delimitMate'                           " Auto-close parans, brackets, quotes, etc.
Plug 'alvan/vim-closetag'                             " Auto-close XML-like tags
Plug 'pbrisbin/vim-mkdir'                             " Automatically create any non-existant directories before writing the buffer
Plug 'wellle/targets.vim'                             " Adds more text objects

" Additional Syntax
Plug 'neoclide/jsonc.vim'

" Personal time tracking
Plug 'wakatime/vim-wakatime'

" Writing
Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-litecorrect'
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-lexical'

call plug#end()

" Allow filetype plugins
filetype plugin indent on

" Enable syntax
syntax on
syntax enable

" I am Canadian
set spelllang=en_ca

" tmux + alacritty + color scheme related
set t_Co=256
if &term =~ '256color' | set t_ut= | endif
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

" Colorscheme in dark mode [iceberg.vim]
colorscheme iceberg
if has('mac')
  if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
  else
    set background=light
  endif
elseif has('unix')
  set background=dark
endif

" For terminal title
set title

" Cosmetic
set number
set ruler
set signcolumn=yes
set noshowmode

" Split behaviour
set splitbelow
set splitright

" Tabs (default width 2, style spaces)
set tabstop=2
set softtabstop=0
set shiftwidth=0
set expandtab
set smarttab
set smartindent
set nojoinspaces
set emoji

" Wrap at 80 for text
set textwidth=80

" Fold all the things
set foldlevel=0
set foldmethod=syntax
set foldtext=CustomFoldText('.')
set fillchars=fold:.

" Allow mouse
set mouse=n

" Use system clipboard
set clipboard+=unnamed
set clipboard+=unnamedplus

" Perf
set ttyfast
set updatetime=250

" Blink the cursor (doesn’t work)
set guicursor=a:blinkon100

" LSP plugins like this
set hidden
set nobackup
set nowritebackup

" Highlight tweaks (pairs well with terminal transparency)
highlight NonText guibg=NONE ctermbg=NONE
highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

" Disable arrow keys for navigation
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Easier split navigation (aligns with Tmux)
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Fuzzy find files [fzf.vim]
nnoremap <C-p> :Files!<CR>

" Show LSP completion [coc.nvim]
inoremap <silent><expr> <c-space> coc#refresh()

" Use enter to confirm completion menu item [coc.nvim]
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use tab + shift-tab for navigating through completion [coc.nvim]
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Italicize word [vim-surround]
nmap <Leader>i T<Space>veS_
let g:surround_{char2nr('i')} = "_\r_"

" Embolden word [vim-surround]
nmap <Leader>b T<Space>veS*gvS*
let g:surround_{char2nr('b')} = "**\r**"

" Show LSP actions menu for selected [coc.nvim]
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

nmap <Leader>d :CocCommand docthis.documentThis<CR>

" Close XML-like tags in JS and JSX files (i.e. for React) [closetag]
let g:closetag_filenames = '*.js,*.jsx'

" vimwiki config [vimwiki]
let g:vimwiki_list = [
  \ { 'path': '~/wiki', 'syntax': 'markdown', 'ext': '.md', 'index': 'main'}
\]
let g:vimwiki_global_ext = 0    " Do not use vimwiki for every Markdown file
let g:vimwiki_auto_header = 1   " Add a header to new files
let g:vimwiki_header_type = '#' " Use Markdown headers

" Avoid truncation in Git commit message subject lines + improve body readability
autocmd FileType gitcommit set tw=72 cc=51,+1

" Auto-source this file it’s written
augroup vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Improve auto closing of stuff for files with JSX [delimitMate]
autocmd FileType javascript,javascriptreact,typescript,typescriptreact let b:delimitMate_matchpairs = "(:),[:],{:}"

" Format code when leaving insert mode [coc.nvim]
autocmd InsertLeave * call CocActionAsync('format') " The wildcard might be a bad idea. Uses prettier if installed, also respects editorconfig

" Highlight symbol when idling cursor on a word [coc.nvim]
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use JSONC for config files that support it [jsonc]
autocmd BufNewFile,BufRead {.eslintrc,tsconfig}.json set syntax=json filetype=jsonc

" Writing [pencil,litecorrect]
augroup pencil
  autocmd!
  autocmd FileType markdown,gitcommit call pencil#init()
        \ | call lexical#init()
        \ | call litecorrect#init()
        \ | call textobj#quote#init()
  autocmd FileType markdown,tex set tw=72
augroup END

let g:airline_section_x = '%{PencilMode()}'
let g:pencil#mode_indicators = {'hard': 'H', 'auto': 'A', 'soft': 'S', 'off': '',}

" Typewriting mode [goyo,limelight]
" the real mvp: https://github.com/junegunn/limelight.vim/issues/39#issuecomment-466664354
let g:limelight_conceal_ctermfg = '#3e445e'
let g:limelight_conceal_guifg = '#3e445e'

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  silent !yabai -m window mouse --toggle native-fullscreen
  set noshowmode
  set noshowcmd
  set scrolloff=999
  nmap j jzz
  nmap k kzz
  nmap G Gzz
  nmap gg ggzz
  Limelight
  let &l:statusline = '%M'
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  silent !yabai -m window mouse --toggle native-fullscreen

  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif

  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Use Ripgrep + FZF for fuzzy searching code (source: FZF plugin README) [fzf.vim + ripgrep]
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nmap <Leader>r :Rg!<CR>

" Copied from Yoshua Wuyts
" https://github.com/yoshuawuyts/dotfiles/blob/93cb44331fdfe09a942c81e33511c61d9db2b662/vim/vimrc#L81-L124
function! CustomFoldText(string)
  let fs = v:foldstart

  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile

  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let pat  = matchstr(&l:cms, '^\V\.\{-}\ze%s\m')
  let line = substitute(line, '^\s*'.pat.'\s*', '', '')
  let pat  = '\%('. pat. '\)\?\s*'. split(&l:fmr, ',')[0]. '\s*\d\+'
  let line = substitute(line, pat, '', '')

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)

  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " "
  let foldLevelStr = '    '
  let lineCount = line("$")
  if has("float")
    try
      let foldPercentage = printf("[%.0f", (foldSize*1.0)/lineCount*100) . "%] "
    catch /^Vim\%((\a\+)\)\=:E806/	" E806: Using Float as String
      let foldPercentage = printf("[of %d] ", lineCount)
    endtry
  endif
  if exists("*strwdith")
      let expansionString = repeat(a:string, w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
        else
      let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, '.', 'x', 'g')))
  endif
  return line . ' ' . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
