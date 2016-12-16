set nu
noremap l t
noremap n <right>
noremap e <left>
noremap s <up>
noremap t <down>
noremap <C-w><S-s> <C-w>s
noremap <C-w>n <C-w><right>
noremap <C-w>e <C-w><left>
noremap <C-w>s <C-w><up>
noremap <C-w>t <C-w><down>
noremap <M-a> 0
noremap <M-o> $

vmap <Tab> =

call plug#begin("~/.config/nvim/plugged")

"Plug 'kassio/neoterm'
"Plug 'neomake/neomake'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jnurmine/Zenburn'

Plug 'rust-lang/rust.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-jedi'

Plug 'tpope/vim-surround'

call plug#end()

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

colors emburn

let g:airline_theme='emburn' " note: small green line in LHS powerline symbol
let g:airline_powerline_fonts = 1
set noshowmode
let g:rustfmt_autosave = 1

:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary=expand("~/Code/racer/target/release/racer")
let g:deoplete#sources#rust#rust_source_path=expand("~/Code/racer/rust/src")

let g:deoplete#sources#jedi#python_path=expand("~/.config/nvim/pynv3/bin/python3")
let g:python_host_prog= expand("~/.config/nvim/pynv2/bin/python")
let g:python3_host_prog=expand("~/.config/nvim/pynv3/bin/python3")

" messing with conceal
set conceallevel=2
set concealcursor="nvci"
syntax keyword Normal lambda conceal cchar=λ
hi clear Conceal
