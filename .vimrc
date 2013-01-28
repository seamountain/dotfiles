" 参考:
"   :help gvimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------
" Vundle用
filetype off
set rtp+=~/.vim/vundle.git
call vundle#rc()


"=============================================
" Vundle用プラグイン
"=============================================
Bundle 'ZenCoding.vim'
Bundle 'visualctrlg'
Bundle 'unite.vim'
Bundle 'unite-font'
Bundle 'unite-colorscheme'
Bundle 'surround.vim'
Bundle 'The-NERD-Commenter'
Bundle 'quickrun.vim'
Bundle 'Haml'
Bundle 'textobj-indent'
Bundle 'textobj-user'
Bundle 'neocomplcache'
Bundle 'colorizer'
Bundle 'Perldoc.vim'
Bundle 'taglist.vim'
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'trinity.vim'
Bundle 'wombat256.vim'
Bundle 'molokai'
Bundle 'railscasts'
Bundle 'Zenburn'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-rails'
Bundle 'jslint.vim'

"---------------------------------------------------------------------------
" カラー設定:
colorscheme wombat256mod

"---------------------------------------------------------------------------
" ウインドウの幅widthとheightを指定すると、numberの位置がずれて、うまく表示されなかった。表示ズレを起こすから、設定しないほうがいい。
"set columns=100
" ウインドウの高さ
"set lines=40
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" 画面を黒地に白にする
"colorscheme evening " (GUI使用時)

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions+=a



"---------------------------------------------------------------------------
"追加した部分
"sasata299さん

if has("autocmd")
  autocmd BufReadPost *
        \if line("'\"") > 0 && line ("'\"") <= line("$") |
        \exe "normal! g'\"" |
        \endif
endif

"---------------------------------------------
autocmd FileType perl :map <C-n> <ESC>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
"autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>
"---------------------------------------------
imap <C-j> <C-[>
imap <C-k> <C-m>
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
"---------------------------------------------

"自分で追加
"---------------------------------------------
set nobackup
set noswapfile

set encoding=utf-8

syntax on

"---------------------------------------------
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
"---------------------------------------------

" インデント
"set autoindent
set smartindent
"set cindent
"タブをスペースに展開しない
"set noexpandtab
"タブをスペースで強制インデント
set expandtab

set tabstop=2 shiftwidth=2 softtabstop=2 "インデント幅を2文字に

"クリップボードにコピー
set clipboard=unnamed,autoselect

"上行末尾の文字を1文字消去 前の行まで削除したい時必須
set backspace=2

"検索語ハイライト
set hlsearch


"vim-ruby設定。使うときは、+rubyになっているかの確認忘れずに
"---------------------------------------------
filetype on
filetype indent on
filetype plugin on "これがついてないと、vim-rubyを呼び出せなかった
"---------------------------------------------

set number
set ruler
set wrap

"set foldmethod=indent
"set foldlevel=1

autocmd FileType ruby :set dictionary=$HOME\.vim\syntax\ruby.vim

"---------------------------------------------

map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>
"---------------------------------------------
"<C-u>でomni補完
imap <C-u> <C-x><C-o>

"Rubyのオムニ補完を設定(ft-ruby-omni)
"let g:rubycomplete_buffer_loading = 1  "これを入れると、segmentation fault で落ちる
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
"---------------------------------------------

"unite設定 scで呼び出し
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
if globpath(&rtp, 'plugin/unite.vim') != ''
  nnoremap sc :<C-u>Unite colorscheme font<Cr>
endif

"---------------------------------------------
"コメントアウト用コマンド
"<Ctrl>lでコメントをトグル(NERD_commenter.vim)
map <C-l> <Leader>c<space>

"iTerm2のショートカット変更により追加
"分割ウィンドウ間移動
map <C-t> <C-W><C-W>

"---------------------------------------------
augroup BufferAu
  autocmd!
  "初期化
  au BufEnter * nnoremap K K
  ".rbファイルでKでRefe検索
  au BufEnter *.rb nnoremap <silent> K :Refe <cword><CR>
augroup END

"set ambiwidth=double


" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
  " .vimrcの再読込時にも色が変化するようにする
  autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
  " .vimrcの再読込時にも色が変化するようにする
  autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
        \if has('gui_running') | source $MYGVIMRC
  autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif


"neocomplcash
let g:neocomplcache_enable_at_startup = 1


"unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
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

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q


"---------------------------------------------
"crontab編集時に、rontab: temp file must be edited in placeと出ないように
set backupskip=/tmp/*,/private/tmp/*

"---------------------------------------------
" Cside_君エントリ参考
" neocomplcache設定
"Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

"Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplcache_ctags_arguments_list = {
      \ 'perl' : '-R -h ".pm"'
      \ }

let g:neocomplcache_snippets_dir = "~/.vim/snippets"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default'    : '',
      \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
      \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" $@
inoremap <C-d> $
inoremap <C-a> @

" .psgi とか .t も Perlなシンタックスハイライト
autocmd BufNewFile,BufRead *.psgi   set filetype=perl
autocmd BufNewFile,BufRead *.t      set filetype=perl

"---------------------------------------------

" Perlのコメントが#になるように
autocmd FileType perl set commentstring=#%s makeprg=perl\ -cw\ -Mstrict\ % errorformat=%m\ at\ %f\ line\ %l%.%#,

" clipboard設定。おそらく効かない
set clipboard=unnamed,autoselect

map > <C-W>5>
map < <C-W>5<

set tags=tags

" srcexpl.vim
"let g:SrcExpl_RefreshTime = 1
"let g:SrcExpl_UpdateTags = 1
let Tlist_Ctags_Cmd = '/usr/local/Cellar/ctags/5.8/bin/ctags'
let g:SrcExpl_updateTagsCmd = "/usr/local/Cellar/ctags/5.8/bin/ctags --sort=foldcase -R ."

if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    "         " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

"let tlist_perl_settings = 'perl;c:class;d:constant;f:function'

" 表示
set laststatus=2
set statusline=%f\ [%{&fenc==''?&enc:&fenc}][%{&ff}]%=%8l:%c%8P

set list
set listchars=tab:__,trail:_

let g:Powerline_symbols = 'fancy'

" TODO: must install node for jslint.vim
let g:JSLintHighlightErrorLine = 1
let $JS_CMD='node'
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=white ctermbg=161

