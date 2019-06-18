" https://github.com/junegunn/vim-plug
" -- PLUGINS --

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'ervandew/supertab'
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'majutsushi/tagbar'
Plug 'matze/vim-move', { 'tag': 'v1.3'}
Plug 'mhinz/vim-startify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'python-mode/python-mode'
Plug 'Rip-Rip/clang_complete'
Plug 'skamsie/nnn'
Plug 'timakro/vim-searchant'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'terryma/vim-multiple-cursors'
Plug 'edkolev/tmuxline.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

"Experimental

"Plug 'AlessandroYorba/Sierra'
"Plug 'metakirby5/codi.vim'
"Plug 'ap/vim-css-color'

call plug#end()

"-- NEOVIM SPECIFIC--

"https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'

:tnoremap <Space><Esc> <C-\><C-n>

"-- GENERAL VIM BELOW THIS LINE --

"set noincsearch
"set iskeyword+=-
set tags+=gems.tags
syntax enable
filetype plugin on
filetype indent on

" global tab settings
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

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

" make sure vertical separator is a |
set fillchars+=vert:│

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
let g:airline#extensions#tabline#buffers_label = '♡ '

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

autocmd Filetype cucumber,css,sass,go,elixir g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd Filetype python let g:SuperTabCompletionContexts =
      \['PyContext', 's:ContextDiscover']

set completeopt+=noselect
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

"-- STARTIFY --
let g:startify_change_to_dir = 0
let g:startify_padding_left = 8
let g:startify_update_oldfiles = 1
let g:startify_custom_header = ['      ' . getcwd()]
let g:startify_files_number = 10
let g:startify_bookmarks =
  \ [
  \   {'c': '~/.vimrc'},
  \   {'l': '~/.zshrc'},
  \   {'f': '~/.config/nvim/init.vim'},
  \   {'t': '~/.tmux.conf'}
  \ ]
let g:startify_commands = [{'n': ':NNN'}]

" This part has to be after the color theme was loaded
highlight StartifySlash ctermfg=11
highlight StartifyFile ctermfg=14
highlight StartifyPath ctermfg=11

" Custom Colors
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=12
hi ErrorMsg cterm=NONE ctermfg=9 gui=bold guifg=Magenta

"-- PYTHON --
function! AddDebugPython()
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
let test#strategy = 'neovim'

" -- RUBY --
" install ctags: brew install ctags
" install rbenv ctags: https://github.com/tpope/rbenv-ctags
" install gem-ctags: gem install gem-ctags
" generate tags in the project dir with: ctags -R .
function! AddDebugRuby()
  execute "normal orequire 'pry'; binding.pry\<Esc>"
endfunction

autocmd Filetype ruby
  \ set colorcolumn=80,120 |
  \ nmap <leader>r :!ruby %<cr> |
  \ map <leader>d :call AddDebugRuby()<cr>

autocmd Filetype javascript set colorcolumn=80

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let ruby_operators = 1
let ruby_space_errors = 1
let ruby_no_expensive = 1

"Overwriting some of the vim-ruby colors
hi rubyPseudoVariable ctermfg=9
hi rubyBoolean ctermfg=9

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

nmap <leader>s :Startify<cr>

"-- GOYO --
let g:goyo_width = 100
let g:goyo_height = "80%"

function! s:goyo_leave()
  set fillchars+=vert:│
  hi VertSplit ctermbg=NONE guibg=NONE
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

"-- NNN ---
let g:nnn_limit_topics_at = 15
let g:nnn_browser = 'firefox'
let g:nnn_nomodifiable = 1
let g:nnn_default_topic_lang = 'en'
let g:nnn_sources = 'wired, hacker-news, cnn, the-next-web, vice-news'
let g:nnn_topics =
  \ [
  \   {'topic': 'machine learning'},
  \   {'topic': 'berlin', 'sort_by': 'popularity', 'language': 'de'},
  \   {'topic': 'politica', 'sort_by': 'popularity', 'language': 'ro'},
  \ ]

function! SetNHColors()
 hi link NHTitle Constant
endfunction`

au! BufEnter,ColorScheme *.news-headlines call SetNHColors()

" -- C --
" Path to clang on OSX High Sierra
let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/' .
  \ 'Toolchains/XcodeDefault.xctoolchain/usr/lib'

autocmd Filetype c
  \ nmap <leader>r :! cc -Wall -std=c99 % -o vimout && ./vimout && rm vimout<CR>

"-- TMUXLINE --
let g:tmuxline_powerline_separators = 1
let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = {
  \  'a'       : '#S',
  \  'c'       : '#{?#{==:#{pane_current_command},ssh},#[fg=yellow]#(ps -t #{pane_tty} -o args= | cut -c 5-)#[fg=default],•}',
  \  'win'     : '#I:#W#F',
  \  'cwin'    : '#I:#W#F',
  \  'y'       : '%H:%M',
  \  'z'       : "#(ps -p #(${CHILD_PID}) -o comm= | cut -c 1-60) #[fg=red, bold]#(${CHILD_PID})#[fg=default]",
  \  'options' : {'status-justify' : 'left'}}

"-- OTHERS --
let g:move_key_modifier = 'C'
" resize vertical split
noremap <c-h> <c-w><
noremap <c-l> <c-w>>
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.xml'
let g:html_indent_inctags = 'html,body,head,tbody,p,nav'
let g:searchant_all = 0
let g:better_whitespace_enabled = 1
