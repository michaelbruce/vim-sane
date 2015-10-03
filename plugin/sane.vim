" vim-same
" Author:       Michael Bruce <http://focalpointer.org/>
" Version:      0.1

" if exists('g:loaded_execute')
"   finish
" endif

let g:loaded_execute = 1


set fileformats=unix,dos,mac " sets the <EOL> chars etc to use
silent! set ttymouse=xterm2 " Fixes delayed tmux mouse issue
set hidden " keep buffers available after closing
