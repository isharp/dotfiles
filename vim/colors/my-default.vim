"these lines are suggested to be at the top of every colorscheme
hi clear
if exists("syntax_on")
	syntax reset
endif

"Load the 'base' colorscheme - the one you want to alter
runtime colors/default.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "my-default"

"Clear the colors for any items that you don't like
hi clear Statement
hi clear Type


"Set up your new & improved colors
hi Statement ctermfg=3* ctermbg=NONE
hi Type ctermfg=Green
hi StatusLine ctermfg=LightRed ctermbg=NONE cterm=NONE
hi Comment ctermfg=4 ctermbg=NONE
