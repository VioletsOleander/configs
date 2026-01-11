vim9script

# when start insert mode, set cursor to steady bar
&t_SI = "\<Esc>[6 q"
# when start replace mode, set cursor to steady block
&t_SR = "\<Esc>[2 q"
# when end insert mode, or replace mode, set cursor to steady block
&t_EI = "\<Esc>[2 q"
# when entering vim (terminal init), set cursor to steady block
# (concatenate the escape code to existing value)
&t_TI ..= "\<Esc>[2 q"
# when leaving vim (terminal exit), restore the cursor shape to terminal default configured by user
# (concatenate the escape code to existing value)
&t_TE ..= "\<Esc>[0 q"

# syntax highlight
syntax enable

# always show the status line at bottom
set laststatus=2

# make search case-insensitive, and but become case-sensitive if it contains any upper-case letter
set ignorecase
set smartcase

# incremental search
set incsearch

# enable mouse in all modes
set mouse=a

# tab and shift (<<, >>) with 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

# do not generate backup file, undo file, swap file
set nobackup
set noundofile
set noswapfile

# no beep and flash when error
set noerrorbells
set vb t_vb=

# no recursive map in normal mode
# map ctrl-v to alt-v
noremap <C-v> <A-v>

# no recursive map in insert mode
# map jj, jk, kk to Esc
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kk <Esc>

# map Alt-n to Esc
inoremap <A-n> <Esc>
