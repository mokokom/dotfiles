call plug#begin('~/.vim/plugged')

Plug 'https://github.com/tpope/vim-rails.git'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'https://tpope.io/vim/commentary.git'
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'https://github.com/morhetz/gruvbox.git'

call plug#end()

" Change LEADER character to comma
let mapleader = ","

syntax on
set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab
if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
" Ignore case in searches
set ignorecase
set number relativenumber

" Toggle NERDTree menu
nmap <leader>n :NERDTreeToggle<CR>
" Remap Esc to quite insert mode 
inoremap jk <Esc>
" Remap FZF plugin
nmap <C-p> :FZF<CR>
" Set the vim directory to the current open file (usefull for NERDTree menu)
:cd %:p:h
" Add linter for ruby and js
let g:ale_linters = {
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}
" Fix errors on save
let g:ale_fixers = {
      \    'ruby': ['standardrb'],
      \}
let g:ale_fix_on_save = 1
" Shows the total number of warnings and errors in the status line
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}
" Change leader key for emmet
let g:user_emmet_leader_key=','
" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

set background=dark
let g:gruvbox_bold=0 
let g:gruvbox_contrast_dark='medium'

colorscheme gruvbox
