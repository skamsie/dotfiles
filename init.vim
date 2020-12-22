" https://github.com/junegunn/vim-plug
" -- PLUGINS --
call plug#begin('~/.local/share/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'timakro/vim-searchant'
Plug 'skamsie/vim-yank-bank'
Plug 'alvan/vim-closetag'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'skamsie/nnn'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mcasper/vim-infer-debugger'
Plug 'skamsie/vim-freestyle'
Plug 'jiangmiao/auto-pairs'
Plug 'skamsie/vim-lineletters'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()

"-- NEOVIM SPECIFIC--
"https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:loaded_python_provider = 0
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'

" -- Misc --
syntax enable
filetype plugin on
filetype indent on
set tags+=gems.tags
set noswapfile
set completeopt+=noselect
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
set ttimeoutlen=10
set updatetime=500
set noerrorbells visualbell t_vb=
" do not show typed chars under statusline
set noshowcmd
" allow changing buffers without saving
set hidden
" reload file written by other program
set autoread
" enable backspace in insert mode
set backspace=indent,eol,start
" always show status line
set laststatus=2
" make sure vertical separator is a │
set fillchars+=vert:│
" yank and paste with the system clipboard
set clipboard=unnamed
" better completion for tab select on files
set wildmode=longest,list
set wildoptions=pum,tagfile

" -- Indentation --
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
autocmd Filetype
      \ ruby,eruby,vim,haml,cucumber,css,sass
      \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype go
      \ setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" -- Search Highlight --
set incsearch
set nohlsearch
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" colorcolumn
autocmd Filetype ruby,python,eruby,vim,javascript
      \ set colorcolumn=80

"-- Colorscheme --
set background=dark
let g:solarized_termtrans = 1
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"
colorscheme solarized

"-- AIRLINE --
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline_extensions = ['tabline', 'whitespace']
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_c = '%f'
let g:airline_section_z = '%-4(%l/%c%) %p%% [%L]'
let g:airline#extensions#tabline#buffers_label = '♡'

"-- NETRW --
let g:netrw_preview = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 33
let g:netrw_localrmdir = 'rm -rf'

"-- STARTIFY --
let g:startify_change_to_dir = 0
let g:startify_padding_left = 8
let g:startify_update_oldfiles = 1
let g:startify_custom_header = ['      ' . getcwd()]
let g:startify_files_number = 10
let g:startify_bookmarks =
      \ [
      \   {'a': '.'},
      \   {'c': '~/.vimrc'},
      \   {'l': '~/.zshrc'},
      \   {'f': '~/.config/nvim/init.vim'},
      \   {'t': '~/.tmux.conf'}
      \ ]
let g:startify_commands = [{'n': ':NNN'}]

" -- VIM-TEST --
let test#python#runner = 'nose'
let test#python#nose#options = '--verbose --nocapture'
let test#strategy = 'neovim'

" -- Ruby --
" install ctags: brew install ctags
" install rbenv ctags: https://github.com/tpope/rbenv-ctags
" install gem-ctags: gem install gem-ctags
" generate tags in the project dir with:
"   ctags -R . && gem ctags && rbenv ctags

let ruby_operators = 1
let ruby_space_errors = 1

" -- FZF --
" Also install with brew: fzf, ag, rg
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let s:fzf_options = {'options': '--delimiter : --nth 4..'}

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \ '--hidden --ignore .git', <bang>0 ?
      \ fzf#vim#with_preview(s:fzf_options, 'up:60%')
      \ : fzf#vim#with_preview(s:fzf_options, 'right:50%:hidden', '?'),
      \ <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading ' .
      \ shellescape(<q-args>), 1, <bang>0 ?
      \ fzf#vim#with_preview(s:fzf_options, 'up:60%')
      \ : fzf#vim#with_preview(s:fzf_options, 'right:50%:hidden', '?'), <bang>0)

let g:fzf_layout =
      \ { 'window': { 'width': 1, 'height': 0.44, 'yoffset': 1 } }

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \   'bg':      ['bg', 'Normal'],
      \   'hl':      ['fg', 'Directory'],
      \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \   'hl+':     ['fg', 'Statement'],
      \   'info':    ['fg', 'PreProc'],
      \   'prompt':  ['fg', 'Conditional'],
      \   'pointer': ['fg', 'Exception'],
      \   'marker':  ['fg', 'Keyword'],
      \   'spinner': ['fg', 'Label'],
      \   'header':  ['fg', 'Comment'] }

" -- GOYO --
let g:goyo_width = 100
let g:goyo_height = "80%"

function! s:goyo_leave()
  set fillchars+=vert:│
  hi VertSplit ctermbg=NONE guibg=NONE
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

" -- NNN ---
let g:nnn_limit_topics_at = 15
let g:nnn_browser = 'firefox'
let g:nnn_nomodifiable = 1
let g:nnn_default_topic_lang = 'en'
let g:nnn_sources = 'wired, hacker-news, ars-technica, vice-news'
let g:nnn_topics =
      \ [
      \   {'topic': 'machine learning'},
      \   {'topic': 'berlin', 'sort_by': 'popularity', 'language': 'de'},
      \   {'topic': 'politica', 'sort_by': 'popularity', 'language': 'ro'},
      \ ]

au! BufEnter,ColorScheme *.news-headlines call SetNHColors()

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.xml'
let g:html_indent_inctags = 'html,body,head,tbody,p,nav'
let g:searchant_all = 0
let g:searchant_map_stop = 0
let g:better_whitespace_enabled = 1

" -- COC --
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? '\<C-n>' :
      \ <SID>check_back_space() ? '\<Tab>' :
      \ coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = ['coc-solargraph']

" Tab selection in popup menus
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:endwise_no_mappings = 1

"fix endwise clashing with coc.nvim
augroup vimrc-ruby-settings
  autocmd!
  autocmd FileType ruby imap <expr> <CR> pumvisible() ?
        \ "\<C-Y>\<Plug>DiscretionaryEnd" :
        \ "\<CR>\<Plug>DiscretionaryEnd"
augroup END

let g:yb_yank_registers = ["j", "k", "l"]
let g:yb_clip_registers = ["x", "y", "z"]

" Disable Coc Linter while easy motion is active
autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd silent! CocEnable

let g:freestyle_settings = { 'no_maps': 1 }
map <C-j> <Plug>FreestyleToggleCursors
map <C-k> <Plug>FreestyleRun

map <expr> <C-c> exists('w:freestyle_data') ?
      \ "\<Plug>FreestyleClear" : "\<Plug>SearchantStop"

" zoom on current window
function! s:zoom()
  if tabpagewinnr(tabpagenr(), '$') > 1
    tab split
  elseif tabpagenr('$') > 1
    if tabpagenr() < tabpagenr('$')
      tabclose
      tabprevious
    else
      tabclose
    endif
  endif
endfunction

" -- MAPPINGS --
" Resize vertical split
noremap <c-h> <c-w><
noremap <c-l> <c-w>>
autocmd filetype netrw noremap <buffer> <c-l> <c-w>>

" Leader
map <Space> <leader>
nmap <leader>f :FZF<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>a :Ag<cr>
nmap <leader>t :Tags<cr>
nmap <leader>h :History<cr>
nmap <leader>s :Startify<cr>
nmap <leader>d :call AddDebugger("o")<cr>
nmap <leader>; <Plug>(easymotion-s)
nmap <silent><leader>z :call <SID>zoom()<cr>

" Others
tnoremap <Space><Esc> <C-\><C-n>
nnoremap g] g<C-]>

" -- SIGNIFY --
let g:signify_sign_delete = '-'
let g:signify_sign_delete_first_line = '-'
let g:signify_sign_change = '~'
let g:signify_sign_show_count = 0

" -- LINELETTERS --
let g:lineletters_settings = {
      \ 'highlight_group': 'MoreMsg',
      \ 'prefix_chars': [',', ';', 'j']
      \ }
map <silent>, <Plug>LineLetters

" CUSTOM COLORS (keep at the end)
hi rubyPseudoVariable ctermfg=9
hi rubyBoolean ctermfg=1
hi rubyDefine cterm=NONE ctermfg=2
hi Comment cterm=italic
hi StartifyPath ctermfg=11
hi StartifySlash ctermfg=11
hi link StartifyFile Normal
hi link CocFloating CursorColumn
hi link CocListBgBlue CursorColumn
hi link NormalFloat CursorColumn
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=12
hi ErrorMsg cterm=NONE ctermfg=9 gui=bold guifg=Magenta
hi! link SignColumn LineNr
hi SpecialKey cterm=bold ctermfg=8 gui=bold guifg=Magenta
hi EasyMotionTarget2First ctermbg=none ctermfg=red
hi EasyMotionTarget2Second ctermbg=none ctermfg=red
hi TabLine cterm=NONE
hi TabLineSel cterm=reverse
hi Visual cterm=reverse ctermfg=11 ctermbg=0
hi MatchParen ctermbg=NONE cterm=italic ctermfg=1
hi SignifySignDelete ctermfg=9 ctermbg=0
hi SignifySignDeleteFirstLine ctermfg=9 ctermbg=0

" Remove this after this bug is fixed:
" https://github.com/vim-airline/vim-airline/issues/2307
autocmd BufEnter * set scroll=5
