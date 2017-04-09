set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="emburn"

let embg = "#202020"
let emfg = "#dcdccc"
let emred = "#cc9393"
let emorange = "#dfaf8f"
let emyellow = "#f0dfaf"
let emyellow_2 = "#d0bf8f"
let emgreen = "#7f9f7f"
let emgreen4 = "#bfdfbf"
let emcyan = "#93e0e3"
let emblue = "#8cd0d3"
let emblue1 = "#9ce0e3"
let emblue_1 = "#7cc0c3"
let emmagenta = "#dc8cc3"

hi Normal guifg=#dcdccc guibg=#202020 ctermfg=15 ctermbg=0
hi Visual guibg=#404040 ctermbg=8
hi Special guifg=#dcdccc guibg=#202020 ctermfg=15 ctermbg=0
" Comments
hi Comment guifg=#7f9f7f ctermfg=2
" Keywords
hi Statement guifg=#f0dfaf gui=bold ctermfg=11 cterm=bold
"hi Keyword guifg=#f0dfaf gui=bold
"hi Conditional guifg=#f0dfaf gui=bold
"hi Delimiter guifg=#f0dfaf gui=bold
hi Delimiter guifg=#dcdccc gui=none ctermfg=15 cterm=none
"hi Repeat guifg=#f0dfaf gui=bold
"hi Label guifg=#f0dfaf gui=bold
"hi Structure guifg=#f0dfaf gui=bold
hi MatchParen cterm=bold ctermbg=0
" Constants
hi Constant guifg=#bfdfbf ctermfg=10
hi Character guifg=#cc9393 ctermfg=1
hi String guifg=#cc9393 ctermfg=1
" Macros
hi PreProc guifg=#93e0e3 ctermfg=14
"Identifiers
hi Function guifg=#93e0e3 ctermfg=14
hi Identifier guifg=#dfaf8f ctermfg=9 cterm=none gui=none
hi Type guifg=#7cc0c3 ctermfg=4
hi Typedef guifg=#7cc0c3 ctermfg=4
" Messages
hi WarningMsg guifg=#d0bf8f ctermfg=3
hi Error guifg=#cc9393 gui=italic guibg=#202020 ctermfg=1 cterm=italic
hi ErrorMsg guifg=#cc9393 gui=italic guibg=#202020 ctermfg=1 ctermbg=0 cterm=italic
" Pmenu
hi Pmenu guifg=#dcdccc guibg=#404040 ctermfg=15 ctermbg=8
hi PmenuSel guifg=#dcdccc guibg=#404040 ctermfg=0 ctermbg=2 cterm=bold
hi PmenuSbar ctermbg=3
hi PmenuThumb ctermbg=2
" StatusLine
hi StatusLine guifg=#dcdccc guibg=#202020 ctermfg=15 ctermbg=0
hi StatusLineNC guifg=#dcdccc guifg=#202020 ctermfg=15 ctermbg=0

" Uncategorized
hi NonText guifg=#dcdccc guibg=#202020 ctermfg=15 ctermbg=0
" Spell
hi SpellBad guifg=#cc9393 gui=italic ctermfg=1 ctermbg=0 cterm=italic

" Tabs
hi TabLineFill ctermfg=0 ctermbg=0 cterm=none
hi TabLineSel ctermbg=0 ctermfg=15 cterm=bold
hi TabLine ctermbg=0 ctermfg=15 cterm=none

set fillchars +=vert:\  

hi Conceal ctermbg=0
hi Folded ctermbg=0 cterm=italic

" Neomake
hi NeomakeWarning ctermfg=9 cterm=underline
