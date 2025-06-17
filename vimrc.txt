let &t_SI = "\e[6 q"
let &t_sr = "\e[4 q"
let &t_EI = "\e[2 q"
" when entering vim
let &t_ti = "\e[2 q"
" when leaving vim
let &t_te = "\e[6 q"

" syntax hilight
syntax on

" always show the status line at bottem
set laststatus=2

" make search case-insenstive, and but become case-senstive if it contains any upper-case letter
set ignorecase
set smartcase

" incremental search
set incsearch

" enable mouse
set mouse+=a