"Clone https://github.com/gmarik/vundle to .vim/bundle at first
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'unite.vim'
Bundle 'unite-colorscheme'
Bundle 'yanktmp.vim'
Bundle 'surround.vim'
Bundle 'textobj-user'
Bundle 'thinca/quickrun.vim'
Bundle 'tyru/open-browser.vim'
Bundle 'superbrothers/vim-quickrun-markdown-gfm'

Bundle 'neocomplcache'
Bundle 'The-NERD-Commenter'
Bundle 'taglist.vim'
Bundle 'Source-Explorer-srcexpl.vim'

Bundle 'airblade/vim-gitgutter'
Bundle 'Lokaltog/vim-powerline'

Bundle 'mattn/emmet-vim'
Bundle 'Haml'
Bundle 'tpope/vim-rails'
Bundle 'jslint.vim'

Bundle 'wombat256.vim'
Bundle 'molokai'
Bundle 'railscasts'
Bundle 'Zenburn'

colorscheme wombat256mod

set nobackup
set noswapfile
set encoding=utf-8

set smartindent
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2 "インデント幅を2文字に

set hlsearch
set number
set ruler
set wrap

imap <C-j> <C-[>
imap <C-k> <C-m>
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

"Fix 'rontab: temp file must be edited in place', when edit crontab.
set backupskip=/tmp/*,/private/tmp/*

"set clipboard=unnamed,autoselect
if stridx(tolower(system('uname')), 'darwin') >= 0 && !has('gui')
  nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
  vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
  nnoremap <silent> <Space>p :r !pbpaste<CR>
  vnoremap <silent> <Space>p :r !pbpaste<CR>
end

set langmenu=ja_jp.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

syntax on

map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

"paste mode toggle
nnoremap <Space>p :<C-u>set paste!<CR>

"iTerm2のショートカット変更により追加
"分割ウィンドウ間移動
map <C-t> <C-W><C-W>

" Shortcut
inoremap <C-d> $
inoremap <C-a> @

"カレントディレクトリを自動で変更する
if exists("+autochdir")
    set autochdir
endif

nnoremap cl :close<CR>


"surround.vim
map <C-l> <Leader>c<space>

"Lokaltog/vim-powerline
set laststatus=2
set statusline=%f\ [%{&fenc==''?&enc:&fenc}][%{&ff}]%=%8l:%c%8P
set list
set listchars=tab:__,trail:_

"neocomplcache
let g:neocomplcache_enable_at_startup = 1

if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)

"unite.vim
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
if globpath(&rtp, 'plugin/unite.vim') != ''
  nnoremap sc :<C-u>Unite colorscheme font<Cr>
endif
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" vim-quickrun-markdown-gf
let g:quickrun_config = {
\   'markdown': {
\     'type': 'markdown/gfm',
\     'outputter': 'browser'
\   }
\ }

" jslint.vim
let g:JSLintHighlightErrorLine = 1
let $JS_CMD='node'
hi clear SpellBad

let g:Powerline_symbols = 'fancy'

"For each filetypes
filetype plugin indent on
