noremap l t
noremap r n
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

map <F1> <del>
map! <F1> <del>

let mapleader = ","

set nu
call plug#begin("~/.config/nvim/plugged")

Plug 'kassio/neoterm'
Plug 'neomake/neomake'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jnurmine/Zenburn'

"Plug 'rust-lang/rust.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-jedi'
" Plug 'artur-shaik/vim-javacomplete2'

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'

Plug 'sheerun/vim-polyglot'

Plug 'mbbill/undotree'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'easymotion/vim-easymotion'

call plug#end()

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set undofile

colors emburn

let g:airline_theme='emburn' " note: small green line in LHS powerline symbol
let g:airline_powerline_fonts = 1
set noshowmode
let g:rustfmt_autosave = 1

:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary=expand("~/.cargo/bin/racer")
let g:deoplete#sources#rust#rust_source_path=expand("~/Code/rust/src/")

let g:deoplete#sources#jedi#python_path=expand("~/.config/nvim/pynv3/bin/python3")
let g:python_host_prog= expand("~/.config/nvim/pynv2/bin/python")
let g:python3_host_prog=expand("~/.config/nvim/pynv3/bin/python3")

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

set fo-=t
autocmd Filetype pandoc setlocal tw=79 fo+=t fo-=l
autocmd Filetype rust let g:AutoPairs = {'`': '`', '"': '"', '{': '}', '(': ')', '[': ']'}

nnoremap <F5> :UndotreeToggle<cr>

set tw=72

function! neomake#makers#cargo#cargo() abort
    return {
        \ 'args': ['check'],
        \ 'errorformat':
            \ neomake#makers#ft#rust#rustc()['errorformat'],
        \ }
endfunction

augroup local_neomake_cmds
    autocmd!
    autocmd BufWritePost *.rs Neomake! cargo
augroup END

nmap <leader>o :Files<Space>
nmap <leader>f :GFiles<Return>
nmap <leader>b :Buffers<Return>
hi NeomakeWarningDefault ctermfg=9

map <Leader><Space> <Plug>(easymotion-prefix)
