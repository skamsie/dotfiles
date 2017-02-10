execute pathogen#infect()

"set colors
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
autocmd Filetype html setlocal ts=2 sts=2 sw=2
set wildmode=longest,list

"status bar (airline)
set laststatus=2
let g:airline_powerline_fonts = 1

"others
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.erb"
let g:move_key_modifier='c'
let g:airline#extensions#tabline#enabled = 1

"code completion, syntax
syntax enable
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"netrw stuff
let g:netrw_liststyle=3
let g:netrw_browse_split = 4
let g:netrw_winsize=25

"viminfo
set viminfo=f0,'0,<0
