" vim-sane
" Author:       Michael Bruce <http://focalpointer.org/>
" Version:      0.1

" if exists('g:loaded_execute')
"   finish
" endif

let g:loaded_execute = 1

" Prevents vim having it's own terminal space
set t_ti= t_te=

set t_Co=256

set fileformats=unix,dos,mac " sets the <EOL> chars etc to use
silent! set ttymouse=xterm2 " Fixes delayed tmux mouse issue
set hidden " keep buffers available after closing

set scrolloff=1 " scroll before the cursor is at the edge
set sidescrolloff=5

set showmatch " Show matching brackets
set list " Display trailing whitespace

" Search preferences
set scs " Case insensitive searches become sensitive with capitals
set gdefault " use /g option by default for :s

" Mode line completion preferences
set wildmenu
set wildmode=longest:full,full
set wildignore+=tags,.*.un~,*.pyc
set wildignorecase

" Folding
set foldmethod=marker
set foldopen+=jump

" Customise display characters used
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
else
set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif

" Backup settings
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set viminfo=!,'20,<50,s10,h

" Better navigation - :e #<NUM & :b TAB/filename OR b<num>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Close/open folds with Tab in normal mode
map <Tab> za
map <S-Tab> zM:echo 'You can also rip with zR'<cr>

" Readline-style key bindings in command-line (excerpt from rsi.vim)
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

