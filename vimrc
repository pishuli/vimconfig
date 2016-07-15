"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle, a plug-in manager for Vim.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up Vundle
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'genutils'
Plugin 'lookupfile'
Plugin 'winmanager'
Plugin 'ShowMarks'
Plugin 'Marks-Browser'
Plugin 'bufexplorer.zip'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/c.vim'
Plugin 'vim-scripts/grep.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bronson/vim-trailing-whitespace'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"set nocompatible

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
set ignorecase

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
set fileformats=unix,dos,mac

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

  " For all text files load abbreviation settings
  autocmd Filetype text source ~/.vim/scripts/abbrevs.vim

  " load skel.c for source files
  " autocmd BufNewFile *.[ch] 0read ~/.vim/scripts/skel.c

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
"set softtabstop=4

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
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Useful mappings for managing tabs
nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>to :tabonly<CR>
nmap <leader>tc :tabclose<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nmap <leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" Switch CWD to the directory of the open buffer
nmap <leader>cd :cd %:p:h<CR>:pwd<CR>

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
nmap <leader>w :w!<CR>
nmap <leader>wq :wq<CR>

" Fast quit
nmap <leader>q :q!<CR>
nmap <leader>qa :qa!<CR>

" Fast split window
nmap <leader>sp :split<CR>

" Fast split window vertical
nmap <leader>vs :vsplit<CR>

" Fast edit
nmap <leader>e :edit<Space>

" Fast buffer switch
nmap <leader>b :buffer<Space>

" Convert the current window into HTML
nmap <leader>th :TOhtml<CR>

" Toggle paste mode on and off
nmap <leader>p :setlocal paste!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
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
    nmap <leader>sc :source ~/.vimrc<CR>
    "Fast editing of .vimrc
    nmap <leader>ec :call SwitchToBuf("~/.vimrc")<CR>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    nmap <leader>sc :source ~/_vimrc<CR>
    "Fast editing of _vimrc
    nmap <leader>ec :call SwitchToBuf("~/_vimrc")<CR>
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
    nmap <leader>m :Man<Space>
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
nmap <leader>tl :TlistToggle<CR>

""""""""""""""""""""""""""""""
" Tag bar
""""""""""""""""""""""""""""""
nmap <leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1

""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 20
nmap <leader>fe :Sexplore!<CR>

""""""""""""""""""""""""""""""
" nerdtree setting
""""""""""""""""""""""""""""""
nmap <leader>nt :NERDTree<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"let g:netrw_home='~/bak'

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

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
let g:winManagerWidth = 30
let g:defaultExplorer = 1
let g:winManagerWindowLayout = "BufExplorer|FileExplorer,TagList"
nmap <C-W><C-F> :FirstExplorerWindow<CR>
nmap <C-W><C-B> :BottomExplorerWindow<CR>
nmap <leader>wm :WMToggle<CR>

""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 4
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
let g:LookupFile_DisableDefaultMap = 1

"(echo "!_TAG_FILE_SORTED	2	/2=foldcase/";
" (find . -type f -printf "%f\t%p\t1\n" | \
" sort -f)) > ./filenametags

if filereadable("./filenametags")
    let g:LookupFile_TagExpr = string('./filenametags')
endif

" Don't display binary files
let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$'

nmap <leader>lk :LUTags<CR>
nmap <leader>lp :LUPath<CR>
nmap <leader>lb :LUBufs<CR>
nmap <leader>lw :LUWalk<CR>
nmap <leader>la :LUArgs<CR>

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

" 0 or s: Find this C symbol
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" 1 or g: Find this definition
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" 2 or d: Find functions called by this function
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" 3 or c: Find functions calling this function
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" 4 or t: Find this text string
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" 6 or e: Find this egrep pattern
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" 7 or f: Find this file
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" 8 or i: Find files #including this file
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>cl :clist!<CR>
nmap <leader>cn :cnext<CR>
nmap <leader>cp :cprevious<CR>
nmap <leader>cw :cw 10<CR>
nmap <leader>cq :cclose<CR>
nmap <leader>cN :cnew<CR>
nmap <leader>col :col<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternate Files quickly (a.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>a :A<CR>
nmap <leader>as :AS<CR>
nmap <leader>av :AV<CR>
nmap <leader>at :AT<CR>
nmap <leader>an :AN<CR>

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
nmap <leader>mc :ShowMarksClearMark<CR>

""""""""""""""""""""""""""""""
" markbrowser setting
""""""""""""""""""""""""""""""
nmap <leader>mk :MarksBrowser<CR>

""""""""""""""""""""""""""""""
" session & viminfo
""""""""""""""""""""""""""""""
nmap <leader>ws :mksession!<Space>
nmap <leader>rs :source<Space>

nmap <leader>wi :wviminfo!<Space>
nmap <leader>ri :rviminfo<Space>

" Set sessionoptions
set sessionoptions=blank,buffers,folds,help,options,tabpages,winsize,sesdir,slash,unix

""""""""""""""""""""""""""""""
" vim-trailing-whitespace
""""""""""""""""""""""""""""""
map <leader><space> :FixWhitespace<CR>

""""""""""""""""""""""""""""""
" nerdcommenter
""""""""""""""""""""""""""""""
let NERDSpaceDelims = 1
" mappings:
" <leader>cc comment out the code selected
" <leader>cu uncomment the code selected

""""""""""""""""""""""""""""""
" vim-powerline
""""""""""""""""""""""""""""""
let g:Powerline_symbols = 'unicode'
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

""""""""""""""""""""""""""""""
" easymotion
""""""""""""""""""""""""""""""
"Default Mappings
"<leader><Leader>f{char}      " Find {char} to the right. See |f|.
"<leader><Leader>F{char}      " Find {char} to the left. See |F|.
"<leader><Leader>t{char}      " Till before the {char} to the right. See |t|.
"<leader><Leader>T{char}      " Till after the {char} to the left. See |T|.
"<leader><Leader>w            " Beginning of word forward. See |w|.
"<leader><Leader>W            " Beginning of WORD forward. See |W|.
"<leader><Leader>b            " Beginning of word backward. See |b|.
"<leader><Leader>B            " Beginning of WORD backward. See |B|.
"<leader><Leader>e            " End of word forward. See |e|.
"<leader><Leader>E            " End of WORD forward. See |E|.
"<leader><Leader>ge           " End of word backward. See |ge|.
"<leader><Leader>gE           " End of WORD backward. See |gE|.
"<leader><Leader>j            " Line downward. See |j|.
"<leader><Leader>k            " Line upward. See |k|.
"<leader><Leader>n            " Jump to latest / or ? forward. See |n|.
"<leader><Leader>N            " Jump to latest / or ? backward. See |N|.
"<leader><Leader>s            " Find(Search) {char} forward and backward. See |f| and |F|.

""""""""""""""""""""""""""""""
" ultisnips
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["~/.vim/snippets"]

""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '>*'
let g:syntastic_enable_highlighting = 0
let g:syntastic_python_checkers=['pyflakes']

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_enable_balloons = 1 "whether to show balloons

""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""
let g:ycm_complete_in_comments = 1
"let g:ycm_complete_in_strings = 1 " Default 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 0 " Default 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_select_completion = ['<C-N>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-P>', '<Up>']
"let g:ycm_key_invoke_completion = '<C-Space>' " Default '<C-Space>'
"let g:ycm_key_detailed_diagnostics = '<leader>d' " Default '<leader>d'
let g:ycm_python_binary_path = 'python'
let g:ycm_global_ycm_extra_conf = '~/.vim/scripts/ycm_extra_conf.py'

set completeopt=longest,menu " close preview window
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1

" mappings
inoremap <C-]>             <C-X><C-]>
inoremap <C-F>             <C-X><C-F>
inoremap <C-D>             <C-X><C-D>
inoremap <C-L>             <C-X><C-L>

inoremap <expr> <CR>       pumvisible() ? "\<C-Y>" : "\<CR>"
inoremap <expr> <C-J>      pumvisible() ? "\<PageDown>\<C-N>\<C-P>" : "\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible() ? "\<PageUp>\<C-P>\<C-N>" : "\<C-K>"
inoremap <expr> <C-U>      pumvisible() ? "\<C-E>" : "\<C-U>"

inoremap <expr> <Up>       pumvisible() ? "\<C-P>" : "\<Up>"
inoremap <expr> <Down>     pumvisible() ? "\<C-N>" : "\<Down>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-P>\<C-N>" : "\<PageUp>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-N>\<C-P>" : "\<PageDown>"

nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>

autocmd InsertLeave * if pumvisible() == 0|pclose|endif " close pum window when leave insert mode
