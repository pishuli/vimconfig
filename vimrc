"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set color scheme
"colorscheme desert
colorscheme desert_my

" Sets how many lines of history VIM has to remember
set history=50

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Set sessionoptions
set sessionoptions=blank,buffers,folds,help,options,tabpages,winsize,sesdir,slash,unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the WiLd menu
set wildmenu

" Always show current position
set ruler

" Show line number
set number

" display incomplete commands
set showcmd

" Height of the command bar
set cmdheight=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Ignore case when searching
"set ignorecase

" When searching try to be smart about cases 
set smartcase

" Show matching brackets when text indicator is over them
set showmatch

" do incremental searching
set incsearch

" A buffer becomes hidden when it is abandoned
set hidden

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("syntax")
  syntax on
endif

if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowb
set nobackup
set noswapfile

" Set to auto read when a file is changed from the outside
set autoread

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent        " always set autoindenting on
  set smartindent       "Smart indent
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set tabstop=4
set shiftwidth=4

" Linebreak on 500 characters
set lbr
set tw=500
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tN :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't use Ex mode, use Q for formatting
map Q gq

" Remap VIM 0 to first non-blank character
"map 0 ^

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q!<cr>
nmap <leader>qa :qa!<cr>

" Fast split window
nmap <leader>sp :split<cr>

" Fast split window vertical
nmap <leader>vs :vsplit<cr>

" Fast edit
nmap <leader>e :edit 

" Fast buffer switch
nmap <leader>b :buffer 

" Convert the current window into HTML
nmap <leader>th :TOhtml<cr>

" Toggle paste mode on and off
map <silent> <leader>p :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Platform detect
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

""""""""""""""""""""""""""""""
" Fast edit vimrc
""""""""""""""""""""""""""""""
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>sc :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ec :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>sc :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ec :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

""""""""""""""""""""""""""""""
" Man page
""""""""""""""""""""""""""""""
if MySys() == "linux"
    " Make ":Man" command available
    source $VIMRUNTIME/ftplugin/man.vim
endif

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
if MySys() == "windows"
    let Tlist_Ctags_Cmd = 'ctags'
elseif MySys() == "linux"
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif

let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

" Toggle tag list on and off
map <silent> <leader>tt :TlistToggle<cr>

""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 20
nmap <silent> <leader>fe :Sexplore!<cr> 

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " New split window is n columns wide.
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber 

"To start exploring in the current window, use: >
" <Leader>be   or   :BufExplorer   or   Your custom key mapping
"To toggle bufexplorer on or off in the current window, use: >
" <Leader>bt   or   :ToggleBufExplorer   or   Your custom key mapping
"To start exploring in a newly split horizontal window, use: >
" <Leader>bs   or   :BufExplorerHorizontalSplit   or   Your custom key mapping
"To start exploring in a newly split vertical window, use: >
" <Leader>bv   or   :BufExplorerVerticalSplit   or   Your custom key mapping

""""""""""""""""""""""""""""""
" winManager setting
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer|FileExplorer,TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 1
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr> 

""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
if filereadable("./filenametags")
    let g:LookupFile_TagExpr = '"./filenametags"'
endif

" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction

let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc' 

nmap <silent> <leader>lp :LUPath<cr>
nmap <silent> <leader>lw :LUWalk<cr>
nmap <silent> <leader>lt :LUTags<cr>
nmap <silent> <leader>la :LUArgs<cr>
nmap <silent> <leader>lk :LUBufs<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csqf=s-,c-,d-,i-,t-,e-
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
  endif
  set csverb
endif

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>cc :cc<cr>
nmap <leader>cl :cl<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr>
nmap <leader>cq :cclose<cr>
nmap <leader>cN :cnew<cr>
nmap <leader>col :col<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternate Files quickly (a.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>a :A<cr>
nmap <leader>as :AS<cr>
nmap <leader>av :AV<cr>
nmap <leader>at :AT<cr>
nmap <leader>an :AN<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grep.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Grep_Default_Options = '-i'
let Grep_Shell_Quote_Char = "'"
let Grep_Shell_Escape_Char = "'"
let Grep_Default_Filelist = '*.c *.cpp *.h *.asm *.S' 

""""""""""""""""""""""""""""""
" showmarks setting
""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1

" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"

" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 

"The following mappings are setup by default:
"
"  <Leader>mt   - Toggles ShowMarks on and off.
"  <Leader>mo   - Forces ShowMarks on.
"  <Leader>mh   - Clears the mark at the current line.
"  <Leader>ma   - Clears all marks in the current buffer.
"  <Leader>mm   - Places the next available mark on the current lineo
nmap <silent> <leader>mc :ShowMarksClearMark<cr> 

""""""""""""""""""""""""""""""
" markbrowser setting
""""""""""""""""""""""""""""""
nmap <silent> <leader>mk :MarksBrowser<cr> 
