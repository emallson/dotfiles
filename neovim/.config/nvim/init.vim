nnoremap n <right>
nnoremap e <left>
nnoremap s <up>
nnoremap t <down>

call plug#begin("~/.config/nvim/plugged")

Plug 'kassio/neoterm'
Plug 'neomake/neomake'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jnurmine/Zenburn'

Plug 'rust-lang/rust.vim'

call plug#end()

colors emburn

let g:airline_theme='emburn' " note: small green line in LHS powerline symbol
let g:airline_powerline_fonts = 1
set noshowmode
let g:rustfmt_autosave = 1

:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
