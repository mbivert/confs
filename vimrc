" Written for vim-7.2

" ------------------------------------------------------------------------------
" -- Globals settings --
" Clear any existing auto command.
autocmd!

" Use vim setting rather than vi's one.ii
set nocp

" Allow backspacing over everything in insert mode.
" Same as:
" set backspace=indent,eol,start
set backspace=2

" Keep 100 lines of command line history.
set history=100

" Number of undo levels.
set undolevels=100

" No annoying beeps.
set noerrorbells

" By default, use the 'g' flag for s(ubstitution).
set gdefault

" Use extended regexp.
set magic

" Autowrite before :next of :make
set autowrite

" Use a .viminfo file, and do not store more than 200 lines of registers.
set viminfo='20,\"50

" Error output format.
set errorformat=%f:%l:%m

" What extensions to ignore for auto-expension.
set wildignore=*.o,*.obj,*.bak,*.back

" Don't jump to the start of line automatically (move to the first non-blank
" character instead).
set nosol

" Show curent mode
set showmode

" Display incomplet commande
set showcmd

" ------------------------------------------------------------------------------
" -- Tab length, indentation settings --
" Number of spaces tab count for.
set tabstop=3

" Number of spaces for shifting (ie >> and << command).
set shiftwidth=3

" If non-zero, number of spaces to insert for a tab.
set softtabstop=3

" We do want no tab; only spaces.
set expandtab

" Use autoindent feature.
set autoindent

" ------------------------------------------------------------------------------
" -- Search settings --
" Begin search at the top of the file when EOL reached.
set wrapscan

" Highlight all matches.
set hls

" Highlight all matches when entering the pattern.
set incsearch

" By default, ignore case in research.
set ignorecase

" But don't ignore it if uppercase chars in search.
set scs

" Jump to matches while entering the pattern.
set sm

" ------------------------------------------------------------------------------
" -- Optimizations settings --
" Turn of scrolling (fastier).
set ttyscroll=0

" Have a fast terminal connection.
set ttyfast

" ------------------------------------------------------------------------------
" -- Encoding settings --
" Set default encoding to utf8
set encoding=utf-8
set fileencoding=utf-8

" ------------------------------------------------------------------------------
" -- Status line settings --
" When to show a status line.
set laststatus=2

" Make the status line a more informative.
set statusline=%F%m%r%h%w\ [%p%%]\ <Format=%{&ff}>\ <Type=%Y>\ <%04l,%03v>

" Change the color of the status line.
if has ("autocmd")
   au InsertEnter * hi StatusLine term=reverse ctermbg=4
   au InsertLeave * hi StatusLine term=reverse ctermbg=2
endif

" ------------------------------------------------------------------------------
" -- GUI settings --
if has ("gui_running")
   " When running ratpoison, ensure vim can use the whole frame ratpoison
   " allocates it.
   set guiheadroom=0

   " Remove menu, toolbar, and scrolling bar.
   set guioptions-=m
   set guioptions-=T
   set guioptions-=r

   " Show lines number on the left.
   set number
   " Set number of columns to use for the line number
   set nuw=5
endif

" ------------------------------------------------------------------------------
" -- Displaying text --
" Number of lines to scroll for ^U and ^D
set scr=10

" When scrolling, number of lines for the context.
set so=3

if has ("autocmd")
   " Use auto file type detection (because this is for real men with big balls)
   filetype plugin indent on

   " Set textwidth to 80.
   autocmd FileType * setlocal textwidth=80

   " Always jump to the last known cursor position, if possible.
   autocmd BufReadPost *
      \ if line ("'\"") > 0 && line ("'\"") <= line ("$") |
      \    exe "normal! g`\"" |
      \ endif
endif

" ------------------------------------------------------------------------------
" -- Remapping --
" Loading a bepo-compatible keymap.
source ~/.vimrc.bepo

" Make < and > more accessible.
noremap « <
noremap » >

" Get new beginning and end of line.
noremap è 0
noremap ç $

" Center page on the cursor with enter.
noremap <Return> zz

" Re-map escape key.
map! ii <Esc>

" Quit with a single q.
map q :q<CR>

" Begin of file with a gg.
map gg 1G

" End of file with a hh.
map hh $G

" Delete every whitespaces at the beginning of the line.
inoremap <F6> :%s/^\s\+//<CR>

" Delete every whitespaces at the end of the line.
map <F7> :%s/\s\+$//<CR>

" Get the date with a <F5>.
map <F5> :r !date<CR> s T

" ------------------------------------------------------------------------------
" -- Mouse settings --
" Yes, we do want to use the mouse.
set mouse=a

" Hide the mouse when typing.
set mousehide

" ------------------------------------------------------------------------------
" -- Syntaxic coloration --
" Automatically activate syntax coloration and last search pattern highlight
if &t_Co > 2 || has ("gui_running")
   syntax on
   set hlsearch
endif

" ------------------------------------------------------------------------------
" -- Typos and abbreviations --
" Some general typos.
iab depht     depth
iab lenght    length
iab monday    Monday
iab tuesday   Tuesday
iab wednesday Wednesday
iab thursday  Thursday
iab friday    Friday
iab saturday  Saturday
iab sunday    Sunday

" For bad typos functions.
nmap :W :w
nmap :Q :q
nmap :WQ :wq

" General abreviations.
iab addrs <mathieu.root@gmail.com>
iab matbiv Mathieu Bivert <mathieu.root@gmail.com>
iab lmodif Last modifications:

" Programming abreviations.
iab wihrle while
iab wire   while
iab rtern  return

if has ("autocmd")
   au BufWinEnter *.c,*.cpp,*.h
      \ iab #i #include|
      \ iab #d #define|
      \ imap « <|
      \ imap » >|
      \ iab inst int|
      \ iab sije_t size_t
endif

" ------------------------------------------------------------------------------
" -- Function definitions/remaps --
" dos2unix and its friend.
command Unix2dos :set ff=unix
command Dos2unix :set ff=dos

" See difference between curent buffer and the file it was loaded from.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
         \ wincmd p | diffthis

" Quit with a single q.
map q :q<CR>

" ------------------------------------------------------------------------------
" -- Matchings/Highlights section --
" Show matching bracets.
set showmatch

if has ("autocmd")
   " Highlight as error characters after columns 80.
   au BufWinEnter * let w:m2=matchadd ('ErrorMsg', '\%>80v.\+', -1)

   " Match EOL spaces.
   au BufWinEnter * let w:m2=matchadd ('ErrorMsg', '\s\+$', -1)
endif

" ------------------------------------------------------------------------------
" -- Loading skeletons.

" ------------------------------------------------------------------------------
" -- Backups --
" Set the place to backup.
set backupdir=~/.vim/backup/

" Keep a backup file automatically.
set backup

" Swap updated after every 50 chars.
set updatecount=50

" vim: ft=vim
