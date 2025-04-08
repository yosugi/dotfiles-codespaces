"" options {{{1 ------------------------------------------------------------------------------------

" indent
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4

" search
set hlsearch
set ignorecase
set incsearch
set smartcase

" parent
set matchtime=1
set showmatch

" etc
set ambiwidth=double
set display=lastline
set hidden
set laststatus=2
set modeline
set showcmd
set visualbell
set wildmenu
set clipboard+=unnamed
set timeoutlen=500
set foldcolumn=0
set foldlevel=0

" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**
set ttyfast lazyredraw

"set iskeyword+=-

"let mapleader = ","

" dirs
let s:homedir=$HOME
let s:tmpdir=s:homedir . '/tmp'
if !isdirectory(s:tmpdir)
    let s:tmpdir='/tmp'
end

if isdirectory(s:tmpdir)
    let &backupdir=s:tmpdir
    let &directory=s:tmpdir
else
    set nobackup
    set noswapfile
end

" NERDTree Flavour netrw
" cf. https://vimconf.org/2019/slides/hezby.pdf
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

autocmd FileType * setlocal formatoptions-=ro

" cf. https://qiita.com/lighttiger2505/items/166a4705f852e8d7cd0d
if has('persistent_undo')
  set undodir=~/.vim/undo
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

"" display {{{1 ------------------------------------------------------------------------------------

syntax enable
set background=dark

set number
set relativenumber

"colorscheme elflord
"colorscheme koehler

if isdirectory(s:homedir . '/.vim/pack/plugins/start/vim-colors-solarized')
    colorscheme solarized
else
    highlight LineNr ctermfg=DarkGray guifg=Grey guibg=Grey90
endif

" show em space
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
autocmd BufRead,BufNew * match JpSpace /　/

" show special chars
set list
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"" key bindings {{{1 -------------------------------------------------------------------------------

" swap semicolon to colon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" select to end of line
nnoremap Y v$

" do not jump
" cf. https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
nnoremap * *``
nnoremap # #``

" CTRL-C and CTRL-Insert are Copy (from mswin.vim)
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" leave insert mode & save
"inoremap <silent> jj <ESC>:<C-u>up<CR>
inoremap <silent> jj <ESC>

" clear search highlight
nnoremap <silent> <C-L> :noh<CR>:redraw<CR>:echo ""<CR>
" https://www.kickbase.net/entry/vim-basic-keymap03
nnoremap <silent> <C-L> :<C-U>nohlsearch<CR><C-L>

" escape register
" cf. https://qiita.com/lighttiger2505/items/166a4705f852e8d7cd0d
"nnoremap x "_x

" Use CTRL-Q to do what CTRL-V used to do
nnoremap <C-Q> <C-V>

" jump last modified line
nnoremap gc `.

" select buffer
nnoremap gb :ls<CR>:b

" tag jump
nnoremap g] g<C-]>
nnoremap <C-]> g<C-]>

" recent file(MRU)
nnoremap gO go
nnoremap go :<C-u>$/ oldfiles<Home>browse filter /
" cf. https://qiita.com/todashuta/items/1362654c6276e5b69abc

" read template
nnoremap gt :r ~/.local/share/templates

" wqa
nnoremap <silent> ZZ :<C-U>wqa<CR>
nnoremap <silent> ZQ :<C-U>qa!<CR>

" jxpand current dir
" cf. http://vimblog.hatenablog.com/entry/vimrc_key_mapping_examples
" cf. [自分のvimでやってきたことのまとめ \- Qiita](https://qiita.com/ykyk1218/items/ab1c89c4eb6a2f90333a)
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')). '/' : '%%'

" sustitute
nnoremap ss s

" paste from yank register
" cf. https://qiita.com/lighttiger2505/items/166a4705f852e8d7cd0d
nnoremap gp "0p
nnoremap gP "0P

" カッコやクオートなどを入力した際に左に自動で移動します
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
"inoremap "" ""<Left>
"inoremap '' ''<Left>
"inoremap <> <><Left>

nnoremap ˙ <C-\><C-n>1gt " ALT + h for mac

"" prefix-key {{{1 ---------------------------------------------------------------------------------

nnoremap [prefix] <nop>
nmap <Space> [prefix]

nnoremap <silent>[prefix]w :<C-u>up<CR>
nnoremap <silent>[prefix]W :e! %<CR>

" switch alternative buffer
nnoremap [prefix]<Space> <c-^>

" paste mode
"autocmd InsertLeave * setlocal nopaste
nnoremap [prefix]pi :setlocal paste<CR>i
nnoremap [prefix]po :setlocal paste<CR>o
nnoremap [prefix]pt :setlocal paste! paste?<CR>
augroup PasteInsert
    autocmd!
    autocmd InsertLeave * setlocal nopaste
augroup END

" very magic search
" cf. https://www.kickbase.net/entry/vim-basic-keymap04
nnoremap [prefix]/ /\v
nnoremap [prefix]?  ?\v

" grep in buffers or arguments
nnoremap [prefix]gb :cexpr []<CR>:bufdo vimgrepadd // %<Left><Left><Left>
nnoremap [prefix]ga :cexpr []<CR>:argdo vimgrepadd // %<Left><Left><Left>

" copy file path of current buffer
" cf. https://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
nnoremap <silent>[prefix]cf :<C-u>let @+ = expand("%:t")<CR>
nnoremap <silent>[prefix]cp :<C-u>let @+ = expand("%:p")<CR>
nnoremap <silent>[prefix]cd :<C-u>let @+ = expand("%:p:h")<CR>

" cf. [Vimで変態テキスト処理！シェルコマンドを使い倒す | DevelopersIO](https://dev.classmethod.jp/articles/vim-use-shellcommands/)
nnoremap <silent>[prefix]x V:!bash<CR>
vnoremap <Space>x :!bash<CR>

"" pairs {{{1 -------------------------------------------------------------------------------

" inspired
" [tpope/vim\-unimpaired: unimpaired\.vim: Pairs of handy bracket mappings](https://github.com/tpope/vim-unimpaired)

" quickfix
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" buffer
nnoremap <silent>[b :bprev<CR>
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[B :bfirst<CR>
nnoremap <silent>]B :blast<CR>

" argument list
nnoremap <silent>[a :prev<CR>
nnoremap <silent>]a :next<CR>
nnoremap <silent>[A :first<CR>
nnoremap <silent>]A :last<CR>

" change list
nnoremap <silent> [c g;
nnoremap <silent> ]c g,
nnoremap <silent> [C 999g;
nnoremap <silent> ]C 999g,

" tagstack
nnoremap <silent>[s :pop<CR>
nnoremap <silent>]s :tag<CR>

" tags match list
nnoremap <silent>[t :tprev<CR>
nnoremap <silent>]t :tnext<CR>
nnoremap <silent>[T :tfirst<CR>
nnoremap <silent>]T :tlast<CR>

" display number
nnoremap <silent>[n :setlocal number<CR>
nnoremap <silent>]n :setlocal nonumber<CR>
"nnoremap <silent>[N :bufdo :setlocal number<CR>
"nnoremap <silent>]N :bufdo :setlocal nonumber<CR>

" number & relativenumber
nnoremap <silent>[N :setlocal number relativenumber<CR>
nnoremap <silent>]N :setlocal nonumber norelativenumber<CR>

" relative number
nnoremap <silent>[or :setlocal relativenumber<CR>
nnoremap <silent>]or :setlocal norelativenumber<CR>

" display cursol line
nnoremap <silent>[ol :setlocal cursorline<CR>
nnoremap <silent>]ol :setlocal nocursorline<CR>

" wrap
nnoremap <silent>[ow :setlocal wrap<CR>
nnoremap <silent>]ow :setlocal nowrap<CR>

" wrapscan
nnoremap <silent>[os :setlocal wrapscan<CR>
nnoremap <silent>]os :setlocal nowrapscan<CR>

"" commands {{{1 ----------------------------------------------------------------------------------

" json
" cf. https://qiita.com/tekkoc/items/324d736f68b0f27680b8
function! s:Jq(...)
    setlocal filetype=json
    syntax on
    setlocal foldmethod=syntax
    setlocal foldlevel=10

    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
command! -nargs=? Jq call s:Jq(<f-args>)

" grep in buffers or arguments
command! -nargs=1 GB cexpr [] | bufdo vimgrepadd /\C<args>/ %
command! -nargs=1 GBI cexpr [] | bufdo vimgrepadd /\c<args>/ %
command! -nargs=1 GA cexpr [] | argdo vimgrepadd /\C<args>/ %
command! -nargs=1 GAI cexpr [] | argdo vimgrepadd /\c<args>/ %

" clip with expand
function! s:ClipEx(expr)
  let @* = expand(a:expr)
  echo "clipped: " . expand(a:expr)
endfunction
command! -nargs=1 ClipEx :call s:ClipEx(<f-args>)

command! Vimrc :e $MYVIMRC

"" terminal {{{1 -----------------------------------------------------------------------------------

" cf. http://blog-sk.com/vim/neovim-settings/
" neovim terminal mapping
if exists(':terminal')
    " launch terminal on new tab
    set termwinkey=<C-u>
    nnoremap <silent>tm :tabe<CR>:terminal ++curwin ++close<CR>
"    nnoremap <silent>tm :terminal ++curwin ++close<CR>
    " to normal mode
    tnoremap <C-o> <C-\><C-n>
    tnoremap ø <C-\><C-n> " ALT + o for mac
    tnoremap ˙ <C-\><C-n>1gt " ALT + h for mac
endif


"" tab page {{{1 -----------------------------------------------------------------------------------

" cf. https://qiita.com/wadako111/items/755e753677dd72d8036d
if v:version >= 700 || has('nvim')
    nnoremap t <Nop>

    " Tab jump
    for n in range(1, 9)
        execute 'nnoremap <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
    endfor
    nnoremap <silent>t0 :tablast<CR>

    " crate new tab right end
    nnoremap <silent>te :tablast<bar> :tabnew<CR>
    " crate tab
    nnoremap <silent>tc :tabnew<CR>
    " close tab
    nnoremap <silent>tx :tabclose<CR>

    " next tab
    nnoremap <silent>tn :tabnext<CR>
    " previous tab
    nnoremap <silent>tp :tabprevious<CR>

    " last tab
    nnoremap <silent>tN :tablast<CR>
    " first tab
    nnoremap <silent>tP :tabfirst<CR>

    " delete other tab
    nnoremap <silent>to :tabonly<CR>
    " copy current tab
    nnoremap <silent>ts :tab split<CR>
endif

"" cursor {{{1 -------------------------------------------------------------------------------------

" cf. https://qiita.com/Linda_pp/items/9e0c94eb82b18071db34
if !has('nvim')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

"" search {{{1 -------------------------------------------------------------------------------------

" cf. https://hogeai.hatenablog.com/entry/2018/03/04/201744
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
    set grepprg=ag\ --nogroup\ -iS
    set grepformat=%f:%l:%m
endif

autocmd QuickFixCmdPost *grep*,make cwindow

" cf. https://thinca.hatenablog.com/entry/20130708/1373210009
autocmd filetype qf noremap <buffer> <CR> <CR>zz<>
autocmd filetype qf setlocal statusline=%t%{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%l/%L
autocmd filetype qf noremap <buffer> <C-n> j<CR>zt<C-w>p
autocmd filetype qf noremap <buffer> <C-p> k<CR>zt<C-w>p

" find files with quickfix
" cf. https://www.reddit.com/r/vim/comments/8p51l6/get_result_of_find_command_up_in_a_quickfix/
function! FindFilesToLocationList(...)
    let l:pattern = '.*'
    if a:0 > 0
        let l:pattern = a:1
    endif
    let l:command = "find . -type d -name .git -prune -o -type f -print | grep '" . l:pattern . "' | xargs -I{} awk '$1 != \"\" && n < 1 {print FILENAME\":1:1:\"$0; n++}' {}"
    if executable('fd')
        let l:command = "fd --type f --no-ignore '" . l:pattern . "' | xargs -I{} awk '$1 != \"\" && n < 1 {print FILENAME\":1:1:\"$0; n++}' {}"
    endif
    cgetexpr system(l:command)
    let w:quickfix_title = l:command
    echo l:command
endfunction
command! -nargs=? FF :call FindFilesToLocationList(<f-args>) | :cw

function! FindGitFilesToLocationList(...)
    let l:pattern = '.*'
    if a:0 > 0
        let l:pattern = a:1
    endif
    let l:command = "find . -type d -name .git -prune -o -type f -print | grep '" . l:pattern . "' | xargs -I{} awk '$1 != \"\" && n < 1 {print FILENAME\":1:1:\"$0; n++}' {}"
    if executable('fd')
        let l:command = "fd --type f '" . l:pattern . "' | xargs -I{} awk '$1 != \"\" && n < 1 {print FILENAME\":1:1:\"$0; n++}' {}"
    elseif executable('rg')
        let l:command = "rg --files | grep '" . l:pattern . "' | xargs -I{} awk '$1 != \"\" && n < 1 {print FILENAME\":1:1:\"$0; n++}' {}"
    endif
    cgetexpr system(l:command)
    let w:quickfix_title = l:command
endfunction
command! -nargs=? FG :call FindGitFilesToLocationList(<f-args>) | :cw

"" abbrev {{{1 ---------------------------------------------------------------------------------------

" cf. https://vim.fandom.com/wiki/Insert_current_date_or_time
iabbrev <expr> y-s/ strftime("%Y-%m-%d %H:%M:%S")
iabbrev <expr> y-d/ strftime("%Y-%m-%d")
iabbrev <expr> y-z/ strftime("%Y-%m-%dT%H:%M:%S%z")
iabbrev <expr> m-s/ strftime("%m-%d %H:%M:%S")
iabbrev <expr> m-d/ strftime("%m-%d")
iabbrev <expr> h-s/ strftime("%H:%M:%S")
iabbrev <expr> h-m/ strftime("%H:%M")
iabbrev <expr> ys/ strftime("%Y%m%d%H%M%S")
iabbrev <expr> yd/ strftime("%Y%m%d")
iabbrev <expr> yz/ strftime("%Y%m%dT%H%M%S%z")
iabbrev <expr> ms/ strftime("%m%d%H%M%S")
iabbrev <expr> md/ strftime("%m%d")
iabbrev <expr> hs/ strftime("%H%M%S")
iabbrev <expr> hm/ strftime("%H%M")

" expand current dir
" cf. http://vimblog.hatenablog.com/entry/vimrc_key_mapping_examples
" cf. [自分のvimでやってきたことのまとめ \- Qiita](https://qiita.com/ykyk1218/items/ab1c89c4eb6a2f90333a)
cabbrev <expr> %% fnameescape(expand('%:h'))

"" task list {{{1 ---------------------------------------------------------------------------------------

" cf. https://qiita.com/naoty_k/items/56eddc9b76fe630f9be7
" easily input task list
iabbrev l/ -
iabbrev t/ [ ]
iabbrev tl/ - [ ]
iabbrev .t/ [ ]
iabbrev .tl/ - [ ]

" toggle checkbox
nnoremap <silent>tt :call ToggleCheckbox()<CR>
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '\[\s\]'
    let l:result = substitute(l:line, '\[\s\]', '[-]', '')
    call setline('.', l:result)
  elseif l:line =~ '\[-\]'
    let l:result = substitute(l:line, '\[-\]', '[x]', '')
    call setline('.', l:result)
  elseif l:line =~ '\[x\]'
    let l:result = substitute(l:line, '\[x\]', '[ ]', '')
    call setline('.', l:result)
  end
endfunction

"" plugins {{{1 ------------------------------------------------------------------------------------

" install
" mkdir -p ~/.vim/pack/plugins/start/ && cd $_
" cat << EOS | xargs -n1 -P6 git clone
" https://github.com/junegunn/fzf.git
" https://github.com/junegunn/fzf.vim.git
" https://github.com/machakann/vim-sandwich.git
" https://github.com/yosugi/tcvime.git
" https://github.com/fuenor/qfixhowm.git
" https://github.com/altercation/vim-colors-solarized.git
" EOS
"
" update
" cd  ~/.vim/pack/plugins/start/
" ls | xargs -P5 -I{} git -C {} pull

""" fzf.vim {{{1 ------------------------------------------------------------------------------------
if isdirectory(s:homedir . '/.vim/pack/plugins/start/fzf.vim')

    let $FZF_DEFAULT_OPTS="--layout=reverse"
    let g:fzf_preview_window = ['up:40%', 'ctrl-/']
"    let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }

    " cf. https://github.com/junegunn/fzf/wiki/Examples-(vim)#filtered-voldfiles-and-open-buffers
    command! FZFMru call fzf#run({
    \ 'source':  reverse(s:all_files()),
    \ 'sink':    'edit',
    \ 'options': '-m -x +s',
    \ 'down':    '40%' })

    function! s:all_files()
      return extend(
      \ filter(copy(v:oldfiles),
      \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
      \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
    endfunction

    " cf. https://github.com/junegunn/fzf.vim/issues/605
    command! -bang Args call fzf#run(fzf#wrap('args',
        \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

    nnoremap [prefix]ff :Files<CR>
    nnoremap [prefix]fg :GFiles<CR>
    nnoremap [prefix]fG :GFiles?<CR>
    nnoremap [prefix]fb :Buffers<CR>
    nnoremap [prefix]b  :Buffers<CR>
    nnoremap [prefix]fa :Args<CR>
    nnoremap [prefix]a  :Args<CR>
    nnoremap [prefix]fr :Rg<CR>
    nnoremap [prefix]fm :Marks<CR>
    nnoremap [prefix]fh :History<CR>
    nnoremap [prefix]f: :History:<CR>
    nnoremap [prefix]f/ :History/<CR>
    nnoremap [prefix]h  :History<CR>
    nnoremap [prefix]fo :FZFMru<CR>
    nnoremap [prefix]o  :FZFMru<CR>

endif

" TODO
" cf. https://wiki.archlinux.jp/index.php/XDG_Base_Directory
" set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p')
" set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p')
" set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p')

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

"if &diff
"    colorscheme blue
"endif

"" tcvime {{{1 -----------------------------------------------------------------------------------------

if isdirectory(expand('~/.vim/pack/plugins/start/tcvime'))
    packadd tcvime
    let tcvime_keymap = 'tutcodes'
    " cf. https://gist.github.com/kozo2/4076375
    if has('keymap')
      set iminsert=0 imsearch=0
      " 切替時にインデントが解除されるのを回避するため、1<C-H>
      inoremap <C-J> 1<C-H><C-O>:call <SID>EnableKeymap('tutcodes')<CR>
      inoremap <silent> <C-L> 1<C-H><C-O>:call <SID>DisableKeymap()<CR>
      inoremap <silent> JJ 1<C-H><C-O>:call <SID>DisableKeymap()<CR><ESC>:<C-u>up<CR>
      inoremap <silent> JK <ESC>:<C-u>up<CR>
    "  inoremap <silent> FF 1<C-H><C-O>:call <SID>DisableKeymap()<CR><ESC>:<C-u>up<CR>
    "  inoremap <silent> FD <ESC>:<C-u>up<CR>
      inoremap <silent> ZZ 1<C-H><C-O>:call <SID>DisableKeymap()<CR><ESC>:<C-u>up<CR>
      inoremap <silent> <ESC> <ESC>:set imsearch=0<CR>:call <SID>DisableKeymap()<CR>
      nnoremap <silent> <C-K>k <Plug>TcvimeNKatakana<CR>
      inoremap <silent> <unique> , <C-G>u<C-R>=tcvime#EnableKeymapOrInsertChar(',',0)<CR>
    endif

    function! s:EnableKeymap(keymapname)
      call tcvime#SetKeymap(a:keymapname)
      " <Space>で前置型交ぜ書き変換を開始するか、読みが無ければ' 'を挿入。
      " (lmapにすると、lmap有効時にfやtやrの後の<Space>が使用不可。(<C-R>=なので))
    "  inoremap <silent> <Space> <Plug>TcvimeIConvOrSpace
    endfunction

    function! s:DisableKeymap()
      let &iminsert = 0
      silent! iunmap <Space>
      TcvimeCloseHelp
    endfunction

    " lmapのカスタマイズを行う関数。
    " tcvime#SetKeymap()からコールバックされる。
    function! TcvimeCustomKeymap()
      " tc2同様の後置型交ぜ書き変換を行うための設定:
      " 活用しない語
      lmap <silent> alj <C-R>=tcvime#InputPostConvertStart(0)<CR>
      lmap <silent> al1 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
      lmap <silent> al2 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
      lmap <silent> al3 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
      lmap <silent> al4 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
      lmap <silent> al5 <C-R>=tcvime#InputPostConvert(5, 0)<CR>
      lmap <silent> al6 <C-R>=tcvime#InputPostConvert(6, 0)<CR>
      lmap <silent> al7 <C-R>=tcvime#InputPostConvert(7, 0)<CR>
      lmap <silent> al8 <C-R>=tcvime#InputPostConvert(8, 0)<CR>
      lmap <silent> al9 <C-R>=tcvime#InputPostConvert(9, 0)<CR>
      lmap <silent> als <C-G>u<Plug>TcvimeIBushu
      lmap <silent> a' <C-G>u<Plug>TcvimeIDisableKeymap
      lmap <silent> <Space>. <C-G>u<Plug>TcvimeIDisableKeymap<Space>
      lmap <silent> <Space>/ <C-G>u<Plug>TcvimeIDisableKeymap<Space>
    endfunction
endif

"" local settings {{{1 -----------------------------------------------------------------------------

runtime! config/*.vim

"" }}}1

"" modeline
" cf. https://qiita.com/naoty_k/items/674787bc2d9885f81a0b
" vim: foldmethod=marker
" vim: foldcolumn=0
" vim: foldlevel=0
" vim: nofoldenable
