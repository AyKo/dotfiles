"---------------------------------------------------------------------------
" vimrc / Ayumu Koujiya
" vim:set ts=2 sts=2 sw=2 tw=0 expandtab:
"---------------------------------------------------------------------------
set nocompatible

"-------------------------------------------------------------------------
" OSタイプを判定しておく
"-------------------------------------------------------------------------
if has('win32')
  let ostype = "Win"
elseif has('mac')
  let ostype = "Mac"
else
  let ostype = system("uname")
endif

"-------------------------------------------------------------------------
" Vundle
"-------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" github
Bundle 'gmarik/vundle'
Bundle 'Shougo/unite.vim'
Bundle 'thinca/vim-ref'
Bundle 'harajune/git-vim'
" www.vim.org
Bundle 'a.vim'
Bundle 'DoxygenToolkit.vim'
filetype plugin indent on

"-------------------------------------------------------------------------
" 色の設定 : koehlerがベース
"-------------------------------------------------------------------------
function! SetColorscheme()
    hi clear
    set background=dark
    if exists("syntax_on")
      syntax reset
    endif
    let g:colors_name = "my-koehler"
    hi Normal         guifg=white guibg=black
    hi Scrollbar      guifg=darkcyan guibg=cyan
    hi Menu           guifg=black guibg=cyan
    hi SpecialKey     term=bold  cterm=none  ctermfg=darkblue  guifg=#0000cc
    hi NonText        term=bold  cterm=bold  ctermfg=darkred  gui=bold      guifg=#cc0000
    hi Directory      term=bold  cterm=bold  ctermfg=brown  guifg=#cc8000
    hi ErrorMsg       term=standout  cterm=bold  ctermfg=grey  ctermbg=red  guifg=White  guibg=Red
    hi Search         term=reverse  ctermfg=white  ctermbg=red      guifg=white  guibg=Red
    hi MoreMsg        term=bold  cterm=bold  ctermfg=darkgreen  gui=bold  guifg=SeaGreen
    hi ModeMsg        term=bold  cterm=bold  gui=bold  guifg=White  guibg=Blue
    hi LineNr         ctermfg=lightgrey ctermbg=darkgrey    guifg=Yellow    guifg=#666666 guibg=#202020
    hi Question       term=standout cterm=bold  ctermfg=darkgreen   gui=bold  guifg=Green
    hi StatusLine     term=bold,reverse  cterm=bold ctermfg=darkblue ctermbg=lightblue gui=bold guifg=blue guibg=white
    hi StatusLineNC   term=reverse  ctermfg=white ctermbg=blue guifg=white guibg=blue
    hi Title          term=bold  cterm=bold  ctermfg=darkmagenta  gui=bold  guifg=Magenta
    hi Visual         term=reverse  cterm=reverse  gui=reverse
    hi WarningMsg     term=standout  cterm=bold  ctermfg=darkred guifg=Red
    hi Cursor         guifg=bg  guibg=Green
    hi Comment        term=bold  cterm=bold ctermfg=cyan  guifg=#80a0ff
    hi Constant       term=underline  cterm=bold ctermfg=magenta  guifg=#ffa0a0
    hi Special        term=bold  cterm=bold ctermfg=red  guifg=Orange
    hi Identifier     term=underline   ctermfg=brown  guifg=#40ffff
    hi Statement      term=bold  cterm=bold ctermfg=yellow  gui=bold  guifg=#ffff60
    hi PreProc        term=underline  ctermfg=darkmagenta   guifg=#ff80ff
    hi Type           term=underline  cterm=bold ctermfg=lightgreen  gui=bold  guifg=#60ff60
    hi Error          term=reverse  ctermfg=darkcyan  ctermbg=black  guifg=Red  guibg=Black
    hi Todo           term=standout  ctermfg=black  ctermbg=darkcyan  guifg=Blue  guibg=Yellow
    hi CursorLine     term=underline  guibg=#555555 cterm=underline
    hi CursorColumn   term=underline  guibg=#555555 cterm=underline
    hi MatchParen     term=reverse  ctermfg=blue guibg=Blue
    hi TabLine        term=bold,reverse  cterm=bold ctermfg=lightblue ctermbg=white gui=bold guifg=blue guibg=white
    hi TabLineFill    term=bold,reverse  cterm=bold ctermfg=lightblue ctermbg=white gui=bold guifg=blue guibg=white
    hi TabLineSel     term=reverse  ctermfg=white ctermbg=lightblue guifg=white guibg=blue
    hi Pmenu          ctermbg=8    guifg=#cccccc guibg=#444444
    hi PmenuSel       ctermbg=12   guifg=#cccccc guibg=DarkCyan
    hi PmenuSbar      ctermbg=0
    hi CursorIM       guibg=Purple guifg=NONE
    hi link IncSearch       Visual
    hi link String          Constant
    hi link Character       Constant
    hi link Number          Constant
    hi link Boolean         Constant
    hi link Float           Number
    hi link Function        Identifier
    hi link Conditional     Statement
    hi link Repeat          Statement
    hi link Label           Statement
    hi link Operator        Statement
    hi link Keyword         Statement
    hi link Exception       Statement
    hi link Include         PreProc
    hi link Define          PreProc
    hi link Macro           PreProc
    hi link PreCondit       PreProc
    hi link StorageClass    Type
    hi link Structure       Type
    hi link Typedef         Type
    hi link Tag             Special
    hi link SpecialChar     Special
    hi link Delimiter       Special
    hi link SpecialComment  Special
    hi link Debug           Special
    if has("gui_running")
        if has("gui_win32")
            set guifont=Migu_1M:h12:cSHIFTJIS
        endif
        set linespace=1
        set guioptions-=T
        set guioptions-=m
        winpos 0 0
        set columns=120
        set lines=50
    endif
endfunction

"-----------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
if has("gui_running")
    gui
    call SetColorscheme()
    if has('multi_byte_ime')
      highlight CursorIM guibg=Purple guifg=NONE
      " 挿入モード・検索モードでのデフォルトのIME状態設定
      set iminsert=0 imsearch=0
    endif
    highlight ZenkakuSpace guibg=#183030
    match ZenkakuSpace /　/
endif

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定
"---------------------------------------------------------------------------
" 賢い自動インデント
set smartindent
" 大文字小文字区別なし
set ignorecase

"---------------------------------------------------------------------------
" 編集に関する設定
"---------------------------------------------------------------------------
" タブスペース4 ソフトウェアタブ4 タブとスペースを混ぜたくない
set ts=4 sw=4 sts=0
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" Backspaceの動作(autoindent超え、改行超え、挿入区間超え)
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1    " ぶら下り可能幅

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"---------------------------------------------------------------------------
" 行番号の表示 (7.0以降で行数の幅が削られるのが気に入らないので拡張)
set number
if version >= 700
  set numberwidth=6
endif
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" タブ文字の表示
set listchars=tab:>\ 
" 折り返しは行われず、長い行は一部のみが表示される
set nowrap
" 常にステータスラインを表示する
set laststatus=2
" コマンドラインに使われるスクリーン上の行数
set cmdheight=2
" コマンドをステータスラインに表示する
set showcmd
" ウィンドウ名にファイル名を表示する
set title
" ビジュアルベル無効
set vb t_vb=
" VisualBell停止
set novisualbell

"---------------------------------------------------------------------------
" backup/swap/undo の設定
"---------------------------------------------------------------------------
" backupファイル
"   winならC:\Documents and Settings\<USER>\My Documents\vim\backup
"   unixなら~/.vim/backup
set backup
if has("gui_win32") && isdirectory($USERPROFILE . '/My Documents/vim/backup')
  let &backupdir = $USERPROFILE . '\My Documents\vim\backup'
elseif isdirectory('~/.vim/backup')
  set backupdir=~/.vim/backup
else
  set nobackup
endif
" swapファイル
"   winならC:\Documents and Settings\<USER>\My Documents\vim\swap
"   unixなら~/.vim/swap
if has("gui_win32") && isdirectory($USERPROFILE . '/My Documents/vim/swap')
  let &directory=$USERPROFILE . '\My Documents\vim\swap'
elseif isdirectory('~/.vim/swap')
  set directory=~/.vim/swap
else
  set noswapfile
endif
" 再読込、vim終了後も継続するアンドゥ(7.3)
"   winならC:\Documents and Settings\<USER>\My Documents\vim\undo
"   unixなら~/.vim/undo
if version >= 703
  if has("gui_win32") && isdirectory($USERPROFILE . '\My Documents\vim\undo')
    set undofile
    let &undodir=$USERPROFILE . '\My Documents\vim\undo'
  elseif isdirectory('~/.vim/undo')
    set undofile
    set undodir=~/.vim/undo
  endif
endif

"---------------------------------------------------------------------------
" GREP
"---------------------------------------------------------------------------
if  has("gui_win32")
  " 内蔵grep
  " set grepprg=internal
  " lv
  "let &grepprg=$VIM . '/external/lv -gn'
  " cygwin grep
  let &grepprg=$VIM . '/external/grep -n'
  " yagrep
  "let &grepprg=$VIM . '/external/yagrep -nH'
else
  "grepコマンドを利用
  set grepprg=grep\ -n
endif
" source $VIMRUNTIME/macros/grepw.vim

"---------------------------------------------------------------------------
" Shell
"---------------------------------------------------------------------------
if has("gui_win32")
  " Bash
  " let &sh=$VIM . '/external/bash'
  "コマンドプロンプト
  "sh=cmd
else
  set sh=bash
endif

"---------------------------------------------------------------------------
" その他の設定
"---------------------------------------------------------------------------
" ファイル名の展開にスラッシュを使う
set shellslash
" タブ文字、行末など不可視文字を表示する。
set list
" ステータス行
"  以下を参考にした
"    http://www.kawaz.jp/pukiwiki/?vim#g59923b3  
"    http://opentechpress.jp/developer/article.pl?sid=07/11/06/0151231
set statusline=%F%m%r%h%w\ %{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%Y]\ <<%4l/%4L(%p%%)\ -\ %v>>
" クリップボードはレジスタ"*"を用いる
set clipboard+=unnamed
" Ctrl+A、Ctrl+Xで8進数は扱わない
set nrformats-=octal
" 自動折りかえしなし
set textwidth=0
" ファイルの最後に<EOL>をつけない
set noeol
" インクリメンタルサーチ
set incsearch
" 検索で小文字なら大文字を無視、大文字なら無視しない設定
set smartcase
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" syntax on
syntax on
" 編集中の内容を保ったまま別の画面に切替えられるようにする
set hid
" 検索結果をハイライト
set hlsearch
" C言語のインデント switchとcaseのインデントを合わせる
set cino=:0
" コメント開始子の後のコメント本文を、配置すべきその他のテキストが無ければ、コメント開始子から 1 文字でインデントする。
set cino=c1
" file typep plugin
filetype plugin on
" Make時にかかった時間を表示したい
"set makeprg=time\ make
set makeprg=make
"set makeprg=scons

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"---------------------------------------------------------------------------
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
"---------------------------------------------------------------------------
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" (Plugin) unite
"  http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin
"-------------------------------------------------------------------------
" 入力モードで開始する
" let g:unite_enable_start_insert=1
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

"---------------------------------------------------------------------------
" (Plugin) MiniBufExplorer
"-------------------------------------------------------------------------
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBuffs = 1
" MiniBufExplorerの最大の高さ
let g:miniBufExplMaxSize = 2

"---------------------------------------------------------------------------
" (Plugin) AutoDate
"-------------------------------------------------------------------------
let g:autodate_keyword_pre = ''
let g:autodate_keyword_post = ''
let g:autodate_format='%Y/%m/%d %H:%M:%S'

"---------------------------------------------------------------------------
" (Plugin) QFixGrep
"-------------------------------------------------------------------------
"Grepコマンドのキーマップ
let MyGrep_Key  = 'g'
"Grepコマンドの2ストローク目キーマップ
let MyGrep_KeyB = ','
"Quickfixウィンドウの高さ
let QFix_Height = 10

"---------------------------------------------------------------------------
" (Plugin) QFixHown
"-------------------------------------------------------------------------
"キーマップリーダー
let QFixHowm_Key = 'g'
"howm_dirはファイルを保存したいディレクトリを設定。
"let howm_dir             = 'c:/howm'
if has("gui_win32")
  let howm_dir = $USERPROFILE.'/My Documents/howm'
else
  let howm_dir = '~/howm'
endif
"一日一ファイルで使用する
"let howm_filename     = '%Y/%m/%Y-%m-%d-000000.howm'
"作成するたびに別ファイル
let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'

"---------------------------------------------------------------------------
" (Plugin) Hown2html
"-------------------------------------------------------------------------
"HTMLファイル出力先
if has("gui_win32")
  let HowmHtml_htmldir = $USERPROFILE.'/My Documents/howm_html'
else
  let HowmHtml_htmldir = '~/howm_html'
endif
let HowmHtml_Vicuna = 'double-l eye-h'


"---------------------------------------------------------------------------
" バイナリモード(vim -b, xxd!)
"-------------------------------------------------------------------------
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

"---------------------------------------------------------------------------
" 文字コードの自動認識
"  http://www.kawaz.jp/pukiwiki/?vim#cb691f26
"-------------------------------------------------------------------------
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
if has("gui_win32")
  set fileformats=dos,unix,mac
else
  set fileformats=unix,dos,mac
endif
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" よくわからないけどSolaris10用(試行錯誤の結果)
if match(ostype, "SunOS") >= 0
  if &term =~ "xterm"
    if has("terminfo")
  "      set t_Co=16
         set t_Co=8
         set t_Sf=1%dm
         set t_Sb=1%dm
    else
  "      set t_Co=16
         set t_Co=8
         set t_Sf=m
         set t_Sb=m
    endif
  endif

  if has("terminfo")
    set t_Co=8
    set t_AB=1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
    set t_AF=1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
  else
    set t_Co=8
    set t_Sf=m
    set t_Sb=m
  endif

  " puttyの端末に、"screen-256color"を設定すればいけた。
  " tmux は、.tmux.confに
  "    set-option -g default-terminal screen-256color

  " vim-help color-xterm より
  ""   256色対応
  "set t_Co=256
  "set t_AB=m
  "set t_AF=m
  "

  " vim-help color-xterm より
  "   TeraTerm Pro用
  "set t_Co=16
  "set t_AB=^[[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{32}%+5;%;%dm
  "set t_AF=^[[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{22}%+1;%;%dm
end

"-------------------------------------------------------------------------
" 色の設定
"---------------------------------------------------------------------------
call SetColorscheme()

"---------------------------------------------------------------------------
" キー設定
"---------------------------------------------------------------------------
" ←キー: バッファ移動(previous)
" map <LEFT> <Esc>:bp<CR>
" →キー: バッファ移動(next)
" map <RIGHT> <Esc>:bn<CR>
" F2: 新しい画面を開いてExplore
map <F2> <Esc>:new<CR>:Explore<CR>
" F10: ハイライトOFF
map <F10> <Esc>:noh<CR>
" Ctrl+N: grep等の時に、次の結果
map <C-n> :cn<Enter>
" Ctrl+P: grep等の時に、前の結果
map <C-p> :cp<Enter>
" マウスの真ん中のボタンはESC
map <MiddleMouse> <Esc>
" マーク位置へのジャンプを行だけでなく桁位置も復元できるようにする
map ' `
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする
imap <C-K>  <ESC>"*pa
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
" Ctrl-E: GTAGSでカーソルの関数にタグジャンプ (下方スクロール動作を上書き)
map <C-e> :GtagsCursor<CR> 
" Alt-y: GTAGSでカーソルの関数の参照検索 (上方スクロール動作を上書き)
map <C-y> :Gtags -r <CR>


"-------------------------------------------------------------------------
" マクロ
"-------------------------------------------------------------------------

"-------------------------------------------------------------------------
" タブとかの設定をemacsモードに
command SetTabEmacs call s:SetTabEmacs()
function! s:SetTabEmacs()
    set ts=8
    set sw=2
    set sts=2
endfunction

command SetTab2 call s:SetTab2()
function! s:SetTab2()
    set ts=8
    set sw=2
    set sts=2
    set expandtab
endfunction

