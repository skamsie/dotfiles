execute pathogen#infect()

"set colors
set background=dark
let g:solarized_termtrans=1
let g:solarized_visibility = "normal"
let g:solarized_contrast = "high"
colorscheme solarized

"omni complete
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview
"autocmd CompleteDone * pclose

"show line numbers
set number

"disable bell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"backspace in Insert mode
set backspace=indent,eol,start


"status bar (airline)
set laststatus=2
set wildmode=longest,list
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"others
set noswapfile
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.erb"
let g:move_key_modifier='c'

"code completion, syntax
syntax enable
filetype plugin indent on
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"netrw stuff
let g:netrw_browse_split = 4
let g:netrw_liststyle=3
let g:netrw_winsize=25
let g:netrw_altv=1

"viminfo
set viminfo=f0,'0,<0

"resize vertical splits with ,.
map , <c-w><
map . <c-w>>

"omni complete on <tab> settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = ""
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:"]
