execute pathogen#infect()

" air-line
let g:airline_powerline_fonts = 1

"set colors
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized

"show line numbers
set number

"disable bell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"backspace in Insert mode
set backspace=indent,eol,start

"indentation
set autoindent
set laststatus=2
set wildmode=longest,list
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.erb"
