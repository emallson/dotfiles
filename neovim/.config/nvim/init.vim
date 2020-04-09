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

let mapleader = ","
let maplocalleader = "\\"

map <F1> <del>
map! <F1> <del>

set nu
set hidden autowrite autoread

if !exists('g:vscode')
    call plug#begin("~/.config/nvim/plugged")

    Plug 'kassio/neoterm'
    " Plug 'neomake/neomake'

    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jnurmine/Zenburn'

    "Plug 'rust-lang/rust.vim'

    " Plug 'HerringtonDarkholme/yats.vim'
    Plug 'leafgarland/typescript-vim'
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'fszymanski/deoplete-emoji'
    " Plug 'sebastianmarkow/deoplete-rust'
    " Plug 'zchee/deoplete-jedi'
    " Plug 'artur-shaik/vim-javacomplete2'

    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'scrooloose/nerdcommenter'

    Plug 'sheerun/vim-polyglot'
    Plug 'lervag/vimtex'
    Plug 'ekalinin/Dockerfile.vim'

    Plug 'mbbill/undotree'

    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }

    " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    " Plug 'junegunn/fzf.vim'

    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'easymotion/vim-easymotion'
    Plug 'farmergreg/vim-lastplace'

    Plug 'dhruvasagar/vim-table-mode'
    Plug 'junegunn/vim-easy-align'

    Plug 'Shougo/echodoc.vim'

    Plug 'tpope/vim-fugitive'
    Plug 'cloudhead/neovim-fuzzy'

    Plug 'junegunn/goyo.vim'
    call plug#end()

    set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
    set undofile

    colors emburn

    let g:airline_theme='emburn' " note: small green line in LHS powerline symbol
    let g:airline_powerline_fonts = 1
    set noshowmode
    let g:echodoc#enable_at_startup = 1
    let g:rustfmt_autosave = 1

    :let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#rust#racer_binary=expand("~/.cargo/bin/racer")
    let g:deoplete#sources#rust#rust_source_path=expand("~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

    let g:deoplete#sources#jedi#python_path=expand("~/.config/nvim/pynv3/bin/python3")
    let g:python_host_prog=expand("~/.config/nvim/pynv2/bin/python")
    let g:python3_host_prog=expand("~/.config/nvim/pynv3/bin/python3")
    autocmd CompleteDone * silent! pclose!

    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1

    set fo-=t
    autocmd Filetype pandoc setlocal tw=79 fo+=t fo-=l
    autocmd Filetype rust let g:AutoPairs = {'`': '`', '"': '"', '{': '}', '(': ')', '[': ']'}

    nnoremap <F5> :UndotreeToggle<cr>

    set tw=72

    " call neomake#configure#automake('nw', 750)

    nmap <leader>f :NERDTree<Return>
    hi NeomakeWarningDefault ctermfg=9

    map <Leader><Space> <Plug>(easymotion-prefix)

    xmap <leader>a <Plug>(EasyAlign)
    xmap <leader>A <Plug>(LiveEasyAlign)

    nmap <leader>b :buffer<space>

    " polyglot configuration
    let g:polyglot_disabled = ['latex']
    " vimtex configuration
    let g:tex_flavor = 'latex'
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    let g:vimtex_view_general_options_latexmk = '--unique'
    noremap <localleader>tsc <plug>(vimtex-cmd-toggle-star)
    noremap <localleader>tse <plug>(vimtex-env-toggle-star)
    noremap <localleader>tsd <plug>(vimtex-delim-toggle-modifier)
    noremap <localleader>tsD <plug>(vimtex-delim-toggle-modifier-reverse)
    inoremap <C-]> <plug>(vimtex-delim-close)
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif
    let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
    let g:vimtex_quickfix_latexlog = {'fix_paths':0}
    let g:vimtex_imaps_leader = '<F9>'
    let g:vimtex_quickfix_autoclose_after_keystrokes = 3
    let g:vimtex_quickfix_open_on_warning = 0

    au FileType javascript setl sw=2 sts=2
    au FileType javascript.jsx setl sw=2 sts=2

    let g:python_highlight_space_errors = 0

    nnoremap <C-p> :FuzzyOpen<CR>

    let g:LanguageClient_serverCommands = {
                \ 'python': ['/home/emallson/.config/nvim/pynv3/bin/pyls'],
                \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
                \ }

    function LC_maps()
        if has_key(g:LanguageClient_serverCommands, &filetype)
            nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
            nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
            nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
        endif
    endfunction

    autocmd FileType * call LC_maps()
else
    call plug#begin("~/.config/nvim/plugged")
    Plug 'tpope/vim-surround'
    call plug#end()

    nmap <leader>s :<C-u>call VSCodeNotify('editor.action.showHover')<CR>
endif
