" vim-sane
" Author:       Michael Bruce <http://focalpointer.org/>
" Version:      0.1

if exists('g:loaded_sane')
  finish
endif

let g:loaded_sane = 1

set nocompatible " First things first, nocompatible mode.
set shell=$SHELL " allows chruby to load
set shortmess+=Ixmn " disables startup message, among other things :help!
set cb=unnamed,unnamedplus " Link clipboard to system clipboard on osx & linux.
set t_ti= t_te= " Prevents vim having it's own terminal space
set t_Co=256

set encoding=utf-8
set fileformats=unix,dos,mac " sets the <EOL> chars etc to use
set hls mouse=a bs=2 is
silent! set ttymouse=xterm2 " Fixes delayed tmux mouse issue
set hidden " keep buffers available after closing

set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround " Rounds shifting (</>) to shiftwidth
set autoindent " copy indentation from previous line.
set expandtab " use spaces, not tabs characters
set smarttab " sw at the start of the line, sts everywhere else
set winwidth=79
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

set autoread " reload a file that has changes outside vim
set autowrite " automatically save before commands like :next and :make

" Display settings
set showmatch " Show matching brackets
set list " Display trailing whitespace
set nowrap " lines should stay as lines.
set cursorline
set lazyredraw
set timeout
set timeoutlen=1200 " A little bit more time for macros
set ttimeoutlen=50  " Make Esc work faster
set scrolloff=3 " scroll before the cursor is at the screen edge
set sidescrolloff=5
set number
set showtabline=1 " show tab bar when there are multiple in use

" Search preferences
set scs " Case insensitive searches become sensitive with capitals
set gdefault " use /g option by default for :s
set ignorecase smartcase

" Mode line completion preferences
set wildmenu
set wildmode=longest,list
" set wildmode=longest:full,full " original
set wildignore+=tags,.*.un~,*.pyc
set wildignorecase
set showcmd " autocomplete commands
set completeopt=menuone,longest

" No folding thanks
set foldmethod=method
set nofoldenable

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

set history=1000
set diffopt=filler,vertical " Options for vimdiff
runtime macros/matchit.vim " use % to jump between start/end of methods
set textwidth=0

" Better navigation - :e #<NUM & :b TAB/filename OR b<num>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Readline-style key bindings in command-line (excerpt from rsi.vim)
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

" Space is a good leader key choice
map <C-q> :q<cr>
map <C-s> :w<cr>
imap <C-s> <esc>:w<cr>

" Stunt jump
map <CR> o<esc>
map <BS> :nohls<cr>
map Q @q
map Y y$
imap <C-e> <C-o>$
imap <C-a> <C-o>^
map <C-w>t :tabe<cr>
map <Leader>u :bNext<CR>
cnoremap <expr> %% expand('%:h').'/'
nmap cx :set cursorline! cursorline?<CR>
nmap gw :e ~/Workspace/

imap <C-k> <space>=><space>

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
command! FindConditionals :normal /\<if\>\|\<unless\>\|\<and\>\|\<or\>\|||\|&&<cr>

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3

augroup sanetypes
  " Auto indent xml files
  au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd! FileType mkd setlocal syn=off
  autocmd! BufNewFile,BufRead *.md setlocal ft=
  autocmd bufwritepost .vimrc source ~/.vimrc
  " Open files at the last viewed position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

augroup END
