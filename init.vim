" https://github.com/junegunn/vim-plug
" -- PLUGINS --

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'timakro/vim-searchant'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'itchyny/calendar.vim'

call plug#end()

"-- NEOVIM SPECIFIC--
"

let g:python_host_prog = '/Users/adimian/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/adimian/.pyenv/versions/neovim3/bin/python'
set noincsearch

:tnoremap <Space><Esc> <C-\><C-n>

"-- GENERAL --

set iskeyword+=-
set tags+=gems.tags
syntax enable
filetype plugin on
filetype indent on

" global tab settings
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" allow changing buffers without saving
set hidden

" do not create swp files
set noswapfile

" reload file written by other program
set autoread

" enable backspace in insert mode
set backspace=indent,eol,start

" always show status bar
set laststatus=2

" yank and paste with the system clipboard
set clipboard=unnamed

" better completion for tab select on files
set wildmode=longest,list

" disable bell
set noerrorbells visualbell t_vb=

set ttimeoutlen=10

autocmd Filetype ruby,eruby,vim,haml,cucumber,css,sass
      \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

"-- COLORS --
set background=dark
let g:solarized_termtrans=1
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"
colorscheme solarized

"-- AIRLINE --
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline_extensions = ['tabline', 'whitespace']
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_c = '%f'
let g:airline#extensions#tabline#buffers_label = 'β'

"-- NETRW --
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_localrmdir = 'rm -rf'

"-- SUPERTAB & OMNI COMPLETE --
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "context"

function! PyContext()
  call pymode#rope#complete(0)
endfunction

autocmd Filetype cucumber,css,sass,go let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd Filetype python let g:SuperTabCompletionContexts =
      \['PyContext', 's:ContextDiscover']

set completeopt+=noselect
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

"-- STARTIFY --
function! startify#fortune#boxed() abort
  return ['      ' . getcwd()]
endfunction

let g:startify_change_to_dir = 0
let g:startify_padding_left = 8
let g:startify_custom_header =  'map([] + startify#fortune#boxed(), "\"   \".v:val")'
let g:startify_update_oldfiles = 1
let g:startify_files_number=10
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, {'l': '~/.zshrc'}, {'f': '~/.config/nvim/init.vim'} ]

" This part has to be after the color theme was loaded
highlight StartifySlash ctermfg=11
highlight StartifyFile ctermfg=14
highlight StartifyPath ctermfg=11

" make split bar thinner
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

"-- PYTHON --
function AddDebugPython()
  execute "normal oimport ipdb; ipdb.set_trace()\<Esc>"
endfunction

autocmd Filetype python
  \ set colorcolumn=100 |
  \ map <leader>d :call AddDebugPython()<cr>

let g:pymode_breakpoint = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_rope_goto_definition_bind = 'gd'
let g:pymode_options = 0
let g:pymode_lint = 0

let test#python#runner = 'nose'
let test#python#nose#options = '--verbose --nocapture'

" -- RUBY --
" install ctags: brew install ctags
" install rbenv ctags: https://github.com/tpope/rbenv-ctags
" install gem-ctags: gem install gem-ctags
" generate tags in the project dir with: ctags -R .
function AddDebugRuby()
  execute "normal orequire 'pry'; binding.pry\<Esc>"
endfunction

autocmd Filetype ruby
  \ set colorcolumn=120 |
  \ nmap <leader>r :!ruby %<cr> |
  \ map <leader>d :call AddDebugRuby()<cr>

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let ruby_operators = 1
let ruby_space_errors = 1
let ruby_no_expensive = 1

" overriting some of the vim-ruby colors
hi rubyPseudoVariable ctermfg=9
hi rubyBoolean ctermfg=9

" -- GO --
let g:go_fmt_autosave = 1
au FileType go nmap <leader>r <Plug>(go-run)

" -- FZF --
"It needs fzf and ag command line tools
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \ <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \   'bg':      ['bg', 'Normal'],
      \   'hl':      ['fg', 'Comment'],
      \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \   'hl+':     ['fg', 'Statement'],
      \   'info':    ['fg', 'PreProc'],
      \   'prompt':  ['fg', 'Conditional'],
      \   'pointer': ['fg', 'Exception'],
      \   'marker':  ['fg', 'Keyword'],
      \   'spinner': ['fg', 'Label'],
      \   'header':  ['fg', 'Comment'] }

nmap <leader>f :FZF<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>a :Ag<cr>
nmap <leader>t :Tags<cr>

"-- CSS-COLOR --
nmap <leader>css :call css_color#toggle()<cr>

" -- MAPS --
map <Space> <leader>

" Resize vertical split with alt+; & alt+'
map … <c-w><
map æ <c-w>>
nmap <leader>s :Startify<cr>

"-- CALENDAR --
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

"-- GOYO --
function! s:goyo_leave()
  set fillchars+=vert:│
  hi VertSplit ctermbg=NONE guibg=NONE
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

"-- OTHERS --

let g:move_key_modifier = 'C'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.xml"
let g:html_indent_inctags = "html,body,head,tbody,p,nav"
let g:searchant_all = 0
let g:better_whitespace_enabled = 1
let g:peekaboo_window = "vert to 40new"
