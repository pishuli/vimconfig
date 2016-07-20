"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ShowMarks'
Plugin 'Marks-Browser'
Plugin 'tomasr/molokai'
Plugin 'kien/ctrlp.vim'
Plugin 'mhinz/vim-grepper'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'klen/python-mode'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Syntax and colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("syntax")
  syntax on
endif

if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

if has('gui_running')
    set background=light
else
    set background=dark
endif

"set background=light

if &background == "light"
    let g:solarized_termcolors=256
    colorscheme solarized_my
else
    let g:rehash256=1
    colorscheme molokai_my
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User interface
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 tab == 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Linebreak on 500 characters
set lbr
set tw=500
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowb
set nobackup

" Set to auto read when a file is changed from the outside
set autoread

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Ignore compiled and backup files
set wildignore=*.o,*.pyc,*~

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" For all text files load abbreviation settings
autocmd Filetype text source ~/.vim/scripts/abbrevs.vim

" For python files tab & indent
" 'et' for expandtab, 'sta' for smarttab, 'sw' for shiftwidth, 'sts' for softtabstop
autocmd FileType python setlocal et sta sw=4 sts=4

" load skel.c for C source files
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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Don't use Ex mode, use Q for formatting
map Q gq

" Remap VIM 0 to first non-blank character
"map 0 ^

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

" Edit file
nmap <leader>e :edit<Space>

" Save file
nmap <leader>w :w!<CR>
nmap <leader>wq :wq<CR>

" Quit window
nmap <leader>q :q!<CR>
nmap <leader>qa :qa!<CR>

" Split window
nmap <leader>sp :split<CR>

" Split window vertical
nmap <leader>vs :vsplit<CR>

" Toggle paste mode on and off
nmap <leader>p :setlocal paste!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast edit vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"Fast reloading of the .vimrc
nmap <leader>sv :source ~/.vimrc<CR>

"Fast editing of .vimrc
nmap <leader>ev :call SwitchToBuf("~/.vimrc")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Man page
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $VIMRUNTIME/ftplugin/man.vim
nmap <leader>m :Man<Space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cscope
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
" Quickfix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List all errors.
nmap <leader>cl :clist!<CR>
" Display the next error in the list
nmap <leader>cn :cnext<CR>
" Display the previous error in the list
nmap <leader>cp :cprevious<CR>
" Open the quickfix window when there are recognized errors
nmap <leader>cw :cw 10<CR>
" Close the quickfix window
nmap <leader>cq :cclose<CR>
" Go to older error list
nmap <leader>co :col<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternate Files quickly (a.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :A switches to the header file corresponding to the current file being edited (or vise versa)
nmap <leader>a :A<cr>
" :AS splits and switches
nmap <leader>as :AS<cr>
" :AV vertical splits and switches
nmap <leader>av :AV<cr>
" :AT new tab and switches
nmap <leader>at :AT<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Showmarks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"  <Leader>mt   - Toggles ShowMarks on and off.
"  <Leader>ma   - Clears all marks in the current buffer.
"  <Leader>mm   - Places the next available mark on the current lineo
nmap <leader>mc :ShowMarksClearMark<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markbrowser
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>mk :MarksBrowser<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Default Mappings, see :help easymotion-default-mappings for more
"<leader><Leader>f{char}      " Find {char} to the right. See |f|.
"<leader><Leader>w            " Beginning of word forward. See |w|.
"<leader><Leader>b            " Beginning of word backward. See |b|.
"<leader><Leader>j            " Line downward. See |j|.
"<leader><Leader>k            " Line upward. See |k|.
"<leader><Leader>s            " Find(Search) {char} forward and backward. See |f| and |F|.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global commands
" :NERDTree [<start-directory> | <bookmark>], help :NERDTree to see more detail
nmap <leader>n :NERDTree<Space>
nmap <leader>nt :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\~$', '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]

" Bookmark commands
" Note that the following commands are only available in the NERD tree buffer.
" :Bookmark [<name>], bookmark the current node as <name>, help :Bookmark to see more detail
nmap <leader>b :Bookmark<Space>
" :ClearBookmarks [<bookmarks>], Remove all the given bookmarks. If no bookmarks are given then remove all bookmarks on the current node.
nmap <leader>bc :ClearBookmarks<Space>

" Mappings
" I.......Toggle whether hidden files displayed....................|NERDTree-I|
" F.......Toggle whether files are displayed.......................|NERDTree-F|
" B.......Toggle whether the bookmark table is displayed...........|NERDTree-B|
" See more details with :help NERDTreeMappings

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ctrlp_map = '<c-p>' " Default
"let g:ctrlp_cmd = 'CtrlP' " Default
let g:ctrlp_user_command =
  \ ['.git', 'cd %s && git ls-files . -co --exclude-standard']

let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_open_new_file = 't'

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

nmap <leader>ff :CtrlP<CR>
nmap <leader>fb :CtrlPBuffer<CR>
nmap <leader>fr :CtrlPMRU<CR>
nmap <leader>ft :CtrlPTag<CR>

" mappings inside CtrlP's prompt,
" see :help ctrlp_prompt_mappings

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grepper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for browsing the input history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

nnoremap <leader>g :Grepper -tool git -cword<cr>
nnoremap <leader>G :Grepper -tool ag -cword<cr>
" see https://github.com/ggreer/the_silver_searcher for more about ag

let g:grepper = {
    \ 'tools': ['ag', 'git', 'grep'],
    \ 'next_tool': '<leader>g',
    \ }

let g:grepper.git =
  \ { 'grepprg': 'git -C `git rev-parse --show-toplevel` grep -nI' }

let g:grepper.grep =
  \ { 'grepprg': 'grep -PRn $* .' } " Use Perl regular expression

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_Ctags_Cmd = '/usr/bin/ctags'

" Toggle tag list on and off
nmap <leader>tl :TlistToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autofocus = 1
nmap <leader>tb :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Task list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>td <Plug>TaskList

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = '<C-TAB>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=longest,menu

let g:ycm_python_binary_path = 'python'

"let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_key_invoke_completion = '<C-Space>' " Default
"let g:ycm_key_detailed_diagnostics = '<leader>d' "Default
let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']

let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf = '~/.vim/scripts/.ycm_extra_conf.py'

nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger       = '<TAB>'
let g:UltiSnipsJumpForwardTrigger  = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:UltiSnipsSnippetDirectories=["~/.vim/snippets", "~/.vim/bundle/vim-snippets/UltiSnips"]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_error_symbol = '✗>'
let g:syntastic_warning_symbol = '*>'
let g:syntastic_python_checkers=['pyflakes']

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_enable_balloons = 1 "whether to show balloons

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sessionman
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>

set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trailing whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader><space> :FixWhitespace<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDSpaceDelims = 1
" mappings:
" <leader>cc
"   Comment out the current line or text selected in visual mode.
" <leader>cu
"   Uncomments the selected line(s).
" <Leader>|c<space>
"   Toggles the comment state of the selected line(s). If the topmost selected
"   line is commented, all selected lines are uncommented and vice versa.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-surround
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode
"  ds  - delete a surrounding
"  cs  - change a surrounding
"  ys  - add a surrounding (Note: "ys" for "you surround")
"  yS  - add a surrounding and place the surrounded text on a new line + indent it
"  yss - add a surrounding to the whole line
"  ySs - add a surrounding to the whole line, place it on a new line + indent it
"  ySS - same as ySs
"
"  Visual mode
"  s   - in visual mode, add a surrounding
"  S   - in visual mode, add a surrounding but place text on new line + indent it
"
" see :help surround for more

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular for aligning text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"To change the hunk-jumping maps (defaults shown):
"  nmap [c <Plug>GitGutterPrevHunk
"  nmap ]c <Plug>GitGutterNextHunk

"To change the hunk-staging/undoing/previewing maps (defaults shown):
"  nmap <Leader>hs <Plug>GitGutterStageHunk
"  nmap <Leader>hu <Plug>GitGutterUndoHunk
"  nmap <Leader>hp <Plug>GitGutterPreviewHunk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " Always show the status line

if &background == "light"
    let g:airline_theme='solarized'
else
    let g:airline_theme='molokai'
endif

let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

let g:airline#extensions#whitespace#enabled = 0

"variable names                default contents
"----------------------------------------------------------------------------
"let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
"let g:airline_section_b       (hunks, branch)
"let g:airline_section_c       (bufferline or filename)
"let g:airline_section_gutter  (readonly, csv)
"let g:airline_section_x       (tagbar, filetype, virtualenv)
"let g:airline_section_y       (fileencoding, fileformat)
"let g:airline_section_z       (percentage, line number, column number)
"let g:airline_section_error   (ycm_error_count, syntastic, eclim)
"let g:airline_section_warning (ycm_warning_count, whitespace)

"let g:airline#extensions#default#layout = [
"    \ [ 'a', 'b', 'c' ],
"    \ [ 'x', 'y', 'z', 'error', 'warning' ]
"    \ ]
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-virtualenv
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"TODO

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"TODO
