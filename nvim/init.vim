" Lots of inspiration from yoshuawuyts and lawsmith

" Display Settings
" ================
set encoding=utf8                           " utf8 everywhere
set t_Co=256                                " Enable 256 colors syntax on                                   " Syntax highlighting on
syntax enable                               " Yep, really
if &term =~ '256color' | set t_ut= | endif  " Disable Background Color Erase (tmux)
if (has("termguicolors")) | set termguicolors | endif

" Plugins
" =======
call plug#begin('~/.local/share/nvim/plugged')
Plug 'cocopon/iceberg.vim'                  " Colour scheme
Plug 'vim-airline/vim-airline'              " Status bar
Plug 'wakatime/vim-wakatime'                " Track my time
Plug 'junegunn/fzf.vim'                     " Fuzzy file search
Plug 'junegunn/fzf', {
\ 'dir': '~/.fzf',
\ 'do': './install --all'
\ }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'francoiscabrol/ranger.vim'            " File explorer
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'                 " Autocomplete brackets
Plug 'tpope/vim-abolish'                    " Add comments in blocks
Plug 'tpope/vim-commentary'                 " Add comments in blocks
Plug 'tpope/vim-repeat'                     " Repeat the last set of commands, rather than single command
Plug 'tpope/vim-surround'                   " Enable inserting brackets around words
Plug 'lfilho/cosco.vim'
Plug 'christoomey/vim-tmux-navigator'       " Seamlessly jump between tmux splits
Plug 'airblade/vim-gitgutter'               " Show git status in the sidebar
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'prettier/vim-prettier', {
\ 'do': 'yarn install',
\ 'for': ['javascript', 'typescript', 'css', 'scss', 'graphql', 'html'] }
Plug 'beanworks/vim-phpfmt'                 " PHP helpers
Plug 'sheerun/vim-polyglot'                 " Language syntax highlighting (Rust, PHP, Markdown, etc.)
Plug 'jparise/vim-graphql'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Language Client for IDE features
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }
Plug 'Shougo/deoplete.nvim', {
\ 'do': ':UpdateRemotePlugins',
\ }
call plug#end()

" Colour Scheme
" =============
colorscheme iceberg

" General Config
" ==============
set nocompatible
set clipboard=unnamed
set number
set ruler
set autoread                                " Reload files changes outside vim;
set laststatus=2                            " Always show status line;
set updatetime=250

" Indentation and Display
" =======================
filetype plugin on
filetype indent on
set guicursor=
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
set linebreak
set textwidth=80                            " This is punchcard;
set nojoinspaces                            " This isn’t a typewriter;
set guicursor=a:blinkon100

" Change the color of the editor after 80 chars, except for the quickfix panel.
let &colorcolumn=join(range(81,999),",")
au FileType qf setlocal nonumber colorcolumn=

" More natural splits
set splitbelow
set splitright

" Enables the ability to use mouse
set mouse=n
set ttyfast
map <ScrollWheelLeft> z<Left>
map <ScrollWheelRight> z<Right>


" Folds
" =====
set foldlevel=0
set foldmethod=syntax
set foldtext=CustomFoldText('.')
set fillchars=fold:.

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

" Auto Commands
" =============
autocmd! BufWritePost vim so ~/.config/nvim/init.vim"  " Automatically reload vimrc when it's saved

" Key bindings
" ============
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-p> :FZF<CR>

" Neo Snippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
map <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Completion
" ==========
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary='/usr/local/bin/racer'

map <Leader>i :!open % /Applications/iA\ Writer.app/<CR><CR>

" Limelight
map <Leader>\ :Goyo<CR>
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_priority = -1
let g:goyo_width = 64
au User GoyoEnter nn j jzz
au User GoyoEnter nn k kzz
au User GoyoEnter nn G Gzz
au User GoyoEnter nn gg ggzz
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Scrolling
" =========
" Start scrolling when we're getting close to margins
set scrolloff=10
set sidescrolloff=15
set sidescroll=1

" Prettier
" ========
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml PrettierAsync

" Airline Settings
" ================
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Language Server
" ===============
let g:LanguageClient_serverCommands = {
\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
\ 'typescript.tsx': ['javascript-typescript-stdio'],
\ 'php': ['$HOME/.composer/vendor/bin/phan', '--language-server-on-stdin'],
\ 'vim': ['vim-language-server', '--stdio'],
\ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
let g:LanguageClient_loggingLevel = 'DEBUG'

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Rust
" ====
au BufRead,BufNewFile *.rs set filetype=rust
" Required for operations modifying multiple buffers like rename.
set hidden

let g:rust_fold = 2
let g:rustfmt_autosave = 1
let g:rust_recommended_style = 1
augroup filetype_rust
  autocmd!
  autocmd BufReadPost *.rs setlocal filetype=rust
  let &colorcolumn=join(range(101,999),",")
  au FileType qf setlocal nonumber colorcolumn=
  set textwidth=100     " Show gutter at 100 chars
augroup END

" PHP
" ===
let g:phpfmt_standard = 'PSR2'
let g:phpfmt_autosave = 0

" Markdown
" ========
au FileType markdown,tex setlocal tw=64 cc=+2
au FileType markdown,tex hi ColorColumn ctermbg=white guibg=white
au FileType markdown,tex nn j jzz
au FileType markdown,tex nn k kzz
au FileType markdown,tex nn G Gzz
au FileType markdown,tex nn gg ggzz

" Git Commit
" ==========
au FileType gitcommit set tw=72 cc=51,+1

" Rg
" ==
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%:hidden', '?'),
\   <bang>0)

" Zoom – from junegunn/dotfiles
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>
