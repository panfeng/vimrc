set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction





""""""""""""""""""""""""""""""added by PanFeng"""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
"colo koehler
"colorscheme desert
"set background=light
set background=dark
colorscheme solarized



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :call VisualSelection('f')<CR>
"vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

nmap <silent> <C-w> :tabclose<CR>
nmap <silent> <C-t> :tabnew<CR>
nmap <silent> <C-j> :tabnext<CR>
nmap <silent> <C-k> :tabprev<CR>
"imap <silent> <C-n> <esc><C-n>
"imap <silent> <C-p> <esc><C-p>


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
"set laststatus=2

" Format the status line
" C;Progra Files (x86)\Vim\_vimrc[+]    CWD: C:\Windows\system32   Line:77
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ \[%p%%]

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222

"color pattern    %number*%     %*
set statusline=
"set statusline +=%1*\ %n\ %*            "buffer ??number??
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
"set statusline +=%1*%4v\ %*             "virtual column number
"set statusline +=%2*0x%04B\ %*          "character under cursor
set statusline +=%5*%P%*                "percentage thru file

set statusline +=%1*%{FileSize()}%*
 function! FileSize()
     let bytes = getfsize(expand("%:p"))
    if bytes <= 0
         return ""
     endif
     if bytes < 1024
         return bytes
     else
         return (bytes / 1024) . "K"
     endif
 endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set encoding=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"set fileformats=unix,dos,mac

"set encoding=utf-8
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin-1
"set termencoding=utf-8

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin-1

"if has("win32") set fileencoding=chinese else set fileencoding=utf-8 endif

"set langmenu=zh_CN.utf-8
set langmenu=en_US.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8


set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest

"Use visual bell instead of beeping.
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
"statusline 那儿已经设置了
"set laststatus=2
set number
"set relativenumber
set undofile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

"Enable filetype plugin
filetype plugin on
filetype indent on

"set to auto read when a file is changed from the outside
set autoread


"With a map leader it's possible to do extra key combinations
"like <leader>w saves the current file
"let mapleader = ","
"let g:mapleader = ","

"Fast saving
"nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
"set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=
set tm=500

"Set at least some personal details into .vimrc by overriding some defaults.
"    The files customization.vimrc and customization.gvimrc are replacements or
"    extensions for your .vimrc and .gvimrc ( _vimrc and _gvimrc under Windows).
"    You may want to use parts of them. The files are documented.
"    Here the minimal personalization (my settings as an example, of course):

      "let g:Lua_AuthorName      = 'Dr.-Ing. Fritz Mehner'
      "let g:Lua_AuthorRef       = 'Mn'
      "let g:Lua_Email           = 'mehner@fh-swf.de'
      "let g:Lua_Company         = 'FH S??dwestfalen, Iserlohn'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


au InsertLeave *.eml write
set autowriteall
set backup
"set backupext=.bak
"set nobackup
"set  noswapfile
set directory=$VIM\temp\swp\
set backupdir=$VIM\temp\backup\


" vimwiki setting from xbeta
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': 'D:/vimwiki/',
\ 'path_html': 'D:/vimwiki/html/',
\ 'html_header': 'D:/vimwiki/template/header.tpl',}]

"setting for vimwiki
if has("win32")
  let $VIMFILES = $VIM.'/vimfiles'
else
  let $VIMFILES = $HOME.'/.vim'
endif

exe "startinsert"


"Full screen
"au GUIEnter * simalt ~x


"nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ev :edit! $MYVIMRC<cr><cr>
"nnoremap <leader>sv :source $MYVIMRC<cr>
autocmd! bufwritepost .vimrc source ~/.vimrc

"不显示vim显示捐款信息
set shortmess=atI

"map ca :Calendar<cr><cr>

"缺省字体，我喜欢大字体
"set guifont=Courier_New:h12:cDEFAULT
set guifont=Consolas:h13:cDEFAULT

" font
"if has('unix')
"    set guifont=Microsoft\ Yahei\ Mono\ 12
"elseif has('win32')
"    set guifont=Microsoft_Yahei_Mono:h12:cGB2312
"endif


nnoremap <c-o> :browse e $vim\Docs<cr>
"nnoremap <c-s> :browse w $VIM\Docs<cr>
nnoremap <F12> :browse w $VIM\Docs<cr>



":e %:h

" In visual mode, use command zf to fold the choosed character.
"nnoremap <space> za

let g:C_ExeExtension = '.exe'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动补全
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"着色模板使用rom
"colo ron
"set showtabline=2
set tabpagemax=25

"use system clipboard
set clipboard=unnamed

"Toggle Menu and Toolbar
"在必要时，可使用 F2 键呼出菜单栏/工具栏；待不使用时，用 F2 键将其关闭。
"set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>


" Nerdtree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




""""""""""""""""""""""""""""""""Vundle set up""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off        " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" vim-scripts repos
filetype plugin indent on    " required!


"相较于Command-T等查找文件的插件，ctrlp.vim最大的好处在于没有依赖，干净利落
Bundle 'ctrlp.vim'

"在输入()，""等需要配对的符号时，自动帮你补全剩余半个
Bundle 'AutoClose'

"神级插件，ZenCoding可以让你以一种神奇而无比爽快的感觉写HTML、CSS
Bundle 'ZenCoding.vim'

"在()、""、甚至HTML标签之间快速跳转；
Bundle 'matchit.zip'

"显示行末的空格；
Bundle 'ShowTrailingWhitespace'

"JS代码格式化插件；
Bundle '_jsbeautify'

"用全新的方式在文档中高效的移动光标，革命性的突破
Bundle 'EasyMotion'

"自动识别文件编码；
Bundle 'FencView.vim'

"必不可少，在VIM的编辑窗口树状显示文件目录
Bundle 'The-NERD-tree'

"NERD出品的快速给代码加注释插件，选中，`ctrl+h`即可注释多种语言代码；
Bundle 'The-NERD-Commenter'

"解放生产力的神器，简单配置，就可以按照自己的风格快速输入大段代码。
"Bundle 'UltiSnips'

"让代码更加易于纵向排版，以=或,符号对齐
Bundle 'Tabular'

"迄今位置最好的自动VIM自动补全插件了吧
"Vundle的这个写法，是直接取该插件在Github上的repo
"Bundle 'Valloric/YouCompleteMe'

"vim-powerline: The ultimate vim statusline utility.
"字体已经fork在github了,下载点击安装即可

Bundle 'Lokaltog/vim-powerline'
let g:Powerline_colorscheme = 'solarized256'
let g:Powerline_symbols = 'fancy'
set t_Co=256
let g:Powerline_cache_enabled = 1
set laststatus=2   " Always show the statusline
set fillchars+=stl:\ ,stlnc:\
set guifont=Consolas\ for\ Powerline\ FixedD:h12



"AuthorInfo : You can add your author info in any source files,such as cpp,c,java,and c#.
Bundle 'AuthorInfo'
let g:vimrc_author='panfeng'
let g:vimrc_email='a008601@gmail.com'
let g:vimrc_homepage='github.com/panfeng'
nmap <F4> :AuthorInfoDetect<cr>

"提供快速注释/反注释代码块的功能
Bundle 'The-NERD-Commenter'

"用来提供单个源代码文件的函数列表之类的功能。最近在使用一个针对面向对象语言的类似插件-tagbar.vim，也很不错。
"下载ctags,将其中的 ctags.exe 复制到gvim.exe 所在的目录，我的是 C:\Program Files\Vim\vim73 如果不复制的话，会出现 Taglist: Exuberant ctags (http://ctags.sf.net) not found in PATH.  Plugin is not loaded."
Bundle 'taglist.vim'


"代码补全
Bundle 'snipMate'

" Color Scheme Explorer : Easy color scheme browsing
Bundle 'Color-Scheme-Explorer'

"auto_mkdir : Allows you to save files into directories that do not exist yet.
"If you're currently in an empty directory, without the plugin, the command
"       :w foo/bar/baz.txt
Bundle 'auto_mkdir'

"L9: Vim-script library
"Bundle 'L9'

"用vim来打造个人wiki
Bundle 'vimwiki'

"提供在vim中打开终端的功能，非常有用！
"Bundle 'conque_term'

"提供日历的功能，并且可以记笔记
"Bunlde 'mattn/calendar-vim'

"提供json的语法高亮
"Bundle 'json.vim'

"提供实时显示颜色的功能，如#FFFFFF
"Bundle 'css.vim'

"提供markdown着色功能，顺便也提供了snippet
"Bundle 'markdown'

"コード入力補完。スニペットも便利。
"Bundle 'Shougo/neocomplcache'

" surround.vim : Delete/change/add parentheses/quotes/XML-tags/much more with ease
Bundle 'tpope/vim-surround'


"A Git wrapper so awesome, it should be illegal.
Bundle 'tpope/vim-fugitive'

"Supertab is a vim plugin which allows you to use <Tab> for all your insert completion needs (:help ins-completion).
Bundle 'ervandew/supertab'


"Precision colors for machines and people.
"下载后把solarized.vim放在vim的colors文件夹下
Bundle 'altercation/vim-colors-solarized'
"dark/light色调切换
call togglebg#map("<F5>")






"放置在Bundle的设置后，防止意外BUG
filetype plugin indent on
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"test"
