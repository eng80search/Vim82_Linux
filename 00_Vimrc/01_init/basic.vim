"----------------------------------------
" 2021/05/09 Linuxバージョン
"----------------------------------------
"テキストモードでの色テーマ
colorscheme  onedark

" beep 音を消す
set belloff=all

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""BackSpaceが効かない問題対策
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start

"プラグインを有効にする
filetype plugin indent on 

"タブページを常に表示
set showtabline=2
""gVimでもテキストベースのタブページを使う
" set guioptions-=e
noremap <Tab> gt<CR>
noremap <S-Tab> gT<CR>


"一行の文字数を制限する
set textwidth=0
if exists('&colorcolumn')
        "set colorcolumn=+1
        autocmd FileType vim, setlocal textwidth=80
endif
"
"********************************************************************************
set number      "行番号を表示する
set cursorline  "カーソル行の背景色を変える
set autochdir   "カレントディレクトリを自動的に変更する
set cursorcolumn "カーソル位置のカラムの背景色を変える
set ignorecase   "検索は大文字小文字の区別をしない

"********************************************************************************
"まずはマイドキュメントディレクトリで該当フォルダを作成すること。
"swapファイルを作成する
set swapfile
set directory=~/.vim/swp

"バックアップファイルを作成する
set backup
set backupdir=~/.vim/backUp

"viminfoファイルの設定を行う
set viminfo+=n~/.vim/viminfo.txt

"永続的にUndoを有効にする
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

"********************************************************************************
set ruler  "ルーラーを表示
syntax on  "シンタックスハイライトを有効にする
set nowrap  "折り返し禁止

"********************************************************************************
set laststatus =2 "ステータス行を常に表示
" set statusline=%F%r%6n(BufNo.)%8L(TotalRow)%8p%%%8l,%c%=TYPE=%y[ENC=%{&fenc}] "ファイルパスの設定 パーセント、行、列設定
"set cmdheight =2  "メッセージ表示欄を２行確保
set showmatch      "対応する括弧を強調表示
set list           "不可視文字を表示

"********************************************************************************
"新しいウィンドウを下に開く
set splitbelow
"新しいウィンドウを右に開く
set splitright

"********************************************************************************
"不可視文字の表示記号設定
set listchars=tab:>-,trail:.,eol:$" タブを >--- 半スペを . で表示する

"インデントをTabではなくスペース４つで揃える
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"********************************************************************************
"起動時のメッセージを表示しない
set  shortmess+=I

"タグジャンプした後は、ジャンプ先を画面先頭に表示
nnoremap  <C-]> <C-]>zz
nnoremap  <C-t> <C-t>zz

"行の初めと終了
noremap <S-h>   ^
noremap <S-l>   $

"画面のスクロール
nnoremap <silent>,h H
nnoremap <silent>,l L
nnoremap <silent>,m M

"行の真ん中にカーソル移動
noremap <silent><S-m> :call cursor(0,strlen(getline("."))/2)<CR>

"スクロール関連ショットカットキー
noremap <S-f> <C-e>
noremap <S-b> <C-y>

noremap <C-j> <C-d> "ページ半分のスクロール
noremap <C-k> <C-u>

"--------------------------------------------------------------------------------
"ウィンドウ系設定
"--------------------------------------------------------------------------------
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く

"ウィンドウサイズ調整
noremap <C-Up> <C-w>-
noremap <C-Down> <C-w>+
noremap <C-Left> <C-w><
noremap <C-Right> <C-w>>

"--------------------------------------------------------------------------------
"バッファ関連設定
"--------------------------------------------------------------------------------
noremap <C-n> :exe("bn!")<CR>
noremap <C-p> :exe("bp!")<CR>
noremap <C-d> :exe("bd")<CR>

"--------------------------------------------------------------------------------
"Vim8.0関連設定
"--------------------------------------------------------------------------------
"スクロールスペースはなしにする
"scrolloff    number of screen lines to show around the cursor
set so=0

"--------------------------------------------------------------------------------
"検索関連設定
"--------------------------------------------------------------------------------
"デフォルトで検索した部分をハイライトする。
set hlsearch
"ハイライトの表示切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
"nnoremap / /\v

"--------------------------------------------------------------------------------
"コマンドウィンドウ設定
"--------------------------------------------------------------------------------
set cmdwinheight=15
"コマンド、検索などの履歴情報の記録数を設定
set history=10000

hi TabLine     term=bold cterm=bold ctermfg=248 ctermbg=239
" hi TabLine     term=reverse cterm=reverse ctermfg=251 ctermbg=235
" hi TabLineSel  term=bold cterm=bold,underline ctermfg=228 ctermbg=240
hi TabLineSel  term=bold cterm=bold,underline ctermfg=220 ctermbg=245
hi TabLineFill term=bold cterm=bold ctermfg=248 ctermbg=237
" set tabline=%{CuiTabLabel()}
:set tabline=%!MakeTabLine()

function! s:tabpage_label(n)
  " n 番目のタブのラベルを返す
  " t:title と言う変数があったらそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '(Changed)' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = fnamemodify(bufname(curbufnr), ":t")
  let bufnum = '['.curbufnr.']'

  let label = mod . sp . bufnum . fname

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = '|'  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  " let info = ''  " 好きな情報を入れる
  " タブページ内のバッファのリスト
  let bufcnt = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
  let info = 'BufferCount: ' . bufcnt

  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction


"--------------------------------------------------------------------------------
"Filetype設定
"--------------------------------------------------------------------------------
set enc=utf-8 "これと同時に_gvimrcにてメニュー文字化け対策が必要
"set fencs=cp932,sjis,euc-jp,iso-2022-jp,utf-8


"--------------------------------------------------------------------------------
"便利のため
"--------------------------------------------------------------------------------
" メニューのショットカットキーAltを無効化する
" set winaltkeys=no
inoremap o <C-[>


"--------------------------------------------------------------------------------
"Terminalモード関連設定
"--------------------------------------------------------------------------------
tnoremap <M-o> <C-w>N<CR>

" インサートモードでもundo
" imap <M-u> <Esc>:undo<CR> i

" インサートモードでもdd
"imap <M-d><M-d> <Esc>dd<CR> i

" " インサートモードでもhjklで移動
" imap <M-h> <Left>
" imap <M-l> <Right>
" imap <M-k> <Up>
" imap <M-j> <Down>

" インサートモードでもhjklで移動
imap h <Left>
imap l <Right>
imap k <Up>
imap j <Down>

"--------------------------------------------------------------------------------
set updatetime=2

" 差分モードのファイルを一気に消す
:command Bdd bd|bd
