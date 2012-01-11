set visualbell
set tabstop=2
set shiftwidth=2
set expandtab
set ls=2
set showcmd
set ruler
set title
set autoindent
set smartindent
set cindent
set nowrap
set number
set guifont=Inconsolta\ 14
syntax enable 
if has('gui_running')
		set background=light
	else
		set background=dark
endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized
