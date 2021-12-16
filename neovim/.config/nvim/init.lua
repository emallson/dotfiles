vim.cmd [[
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
noremap <M-o> <End>
noremap gb <C-o>
noremap <M-x> :

let mapleader = ","
let maplocalleader = ",m"

set termguicolors
set background=light

set autoindent
set tabstop=2 expandtab shiftwidth=2

colorscheme plain

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]]

require('plugins');

require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = true,
		extended_mode = true
	},
  rainbow_identifiers = {
    enable = true,
  }
})
