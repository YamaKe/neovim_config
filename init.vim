" Source the neo vim config
command! NeoSource :Source ~/.config/nvim/init.vim

" Install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
" colorscheme
Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'

Plug 'Yggdroot/indentLine'

Plug 'itchyny/lightline.vim'

Plug 'kien/ctrlp.vim'
call plug#end()
" }}}

" Colors {{{
syntax on
" ayu {{{
set termguicolors
"let ayucolor="dark"
let ayucolor="mirage"
colorscheme ayu
" }}}

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screens
  set t_ut=
endif
" }}}

" Indent Line {{{
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}}

" lightline {{{
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
      \   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
      \ },
      \ 'separator': {'left': "\ue0b0", "right": "\ue0b2"},
      \ 'subseparator': {'left': "\ue0b1", "right": "\ue0b3"},
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ }
      \}
" }}}

" Spaces & Tabs {{{
set tabstop=2                 " number of visual spaces per TAB
set softtabstop=2             " number of spaces in tab when editing
set shiftwidth=2              " number of spaces to use for autoindent
set expandtab                 " tabs are spaces
set autoindent
set copyindent                " copy indent from previous line

au BufWritePre * :%s/\s\+$//e " remove trailing whitespace
" }}}

" UI {{{
set number                    " show line number
set showcmd                   " show command in bottom bar
set cursorline                " highlight current line
set wildmenu                  " visual autocomplete for command menu
set noshowmode                " no -- INSERT -- -- NORMAL -- for lightline
set showmatch
set laststatus=2
set guicursor=a:blinkon100    " blink cursor
" }}}

" Indentation {{{
set wrap
set linebreak
set nolist
set breakindent
set breakindentopt=shift:2
" }}}

" Search {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
" }}}

" Tab AutoComplete "
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
