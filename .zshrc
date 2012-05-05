# ---------------------------------------------------------------
# .zshrc
#
# tsakaの日記
# http://d.hatena.ne.jp/tsaka/20060819/1162739565
#
# 俺のメモ
# http://d.hatena.ne.jp/kayai/20101222/1293032489
#
# 漢のzsh
# http://news.mynavi.jp/column/zsh/index.html
# ---------------------------------------------------------------

export LANG=ja_JP.UTF-8		   	# ロケールの設定
export EDITOR=vim                  	# エディタ
export LISTMAX=0                   	# 補完リストが多い場合に尋ねるか -1:尋ねない, 0:ウインドウから溢れるとき
setopt ignoreeof                        # ^D でexit しない。10回連続するとログアウト
export WORDCHARS='*?_.[]~=&;!#$%^(){}<>' # Ctrl+wで､直前の/までを削除する｡
setopt rm_star_silent                    # "rm * " を実行する前に確認
setopt print_eight_bit                   # 日本語を正しく表示
setopt bsd_echo                          # echo を BSD互換に

alias ls='ls --show-control-chars --color=auto -F'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias w3m=$HOME/bin/w3m
alias google='w3m google.co.jp'
alias groff-man='groff -mandoc -Tutf8'

## xterm-256colorが可能なら設定する
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

## プロンプトの設定
#
autoload colors
colors
PROMPT="%{${fg[green]}%}[%n@%m] %{${fg[yellow]}%}%~
%{${reset_color}%}%(!.#.$) "
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT=""

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

## Keybind configuration
#
# vi like keybind
bindkey -v
 
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end

# 履歴ファイルに時刻を記録
setopt extended_history

## Completion configuration
#
autoload -U compinit
compinit

# no beep sound when complete list displayed
setopt nolistbeep

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# cdのタイミングで自動的にpushd
setopt auto_pushd 

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# シェルのプロセスごとに履歴を共有
setopt share_history

# 補完候補が複数ある時に、一覧表示
setopt auto_list

# 保管結果をできるだけ詰める
setopt list_packed

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさないようにする
setopt no_beep

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store

# 余分なスペースを削除してヒストリに記録する
setopt hist_reduce_blanks

# 行頭がスペースで始まるコマンドラインはヒストリに記録しない
# setopt hist_ignore_spece

# 重複したヒストリは追加しない
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt no_list_types

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

