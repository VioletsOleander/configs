" when start insert mode
let &t_SI = "\e[6 q"
" when start replace mode
let &t_sr = "\e[4 q"
" when end insert mode
let &t_EI = "\e[2 q"
" when entering vim (terminal init)
let &t_ti = "\e[2 q"
" when leaving vim (terminal exit)
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

" enable mouse in all modes
set mouse+=a

" tab and shift (<<, >>) with 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" do not generate backup file, undo file, swap file
set nobackup
set noundofile
set noswapfile

" no beep and flash when error
set noerrorbells
set vb t_vb=

" no recursive map in normal mode
" map ctrl-v to alt-v
noremap <C-v> <A-v>

" no recursive map in insert mode
" map jk to Esc
inoremap jk <Esc>
