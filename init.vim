" https://github.com/junegunn/vim-plug
" -- PLUGINS --
call plug#begin('~/.local/share/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'qxxxb/vim-searchhi'
Plug 'skamsie/vim-yank-bank'
Plug 'alvan/vim-closetag'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'skamsie/nnn'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mcasper/vim-infer-debugger'
Plug 'jiangmiao/auto-pairs'
Plug 'skamsie/vim-lineletters'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'AndrewRadev/splitjoin.vim'

"-- EXPERIMENTS
"Plug 'xolox/vim-notes'
"Plug 'xolox/vim-misc'
"Plug 'MunifTanjim/nui.nvim'

call plug#end()

"-- NEOVIM SPECIFIC--
"https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:loaded_python_provider = 0
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'

"-- SETTINGS --
syntax enable
filetype plugin on
filetype indent on
set matchpairs+=<:>
set tags+=gems.tags
set noswapfile
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
set ttimeoutlen=10
set updatetime=500
set noerrorbells visualbell t_vb=
set colorcolumn=80
" do not show typed chars under statusline
set noshowcmd
" allow changing buffers without saving
set hidden

" better search
" https://vim.fandom.com/wiki/Searching
set ignorecase
set smartcase

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
" indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" search highlight
" set incsearch
" set nohlsearch

"-- COLORSCHEME --
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
let g:airline_section_z = '%-4(%l:%c%) %p%% [%L]'
let g:airline#extensions#tabline#buffers_label = '♡ '

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

" -- RUBY --
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
      \  call fzf#vim#ag(<q-args>,
      \    '--hidden --ignore .git', <bang>0 ?
      \ fzf#vim#with_preview(s:fzf_options, 'up:60%')
      \ : fzf#vim#with_preview(s:fzf_options, 'right:50%', '?'),
      \ <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading ' .
      \ shellescape(<q-args>), 1, <bang>0 ?
      \ fzf#vim#with_preview(s:fzf_options, 'up:60%')
      \ : fzf#vim#with_preview(s:fzf_options, 'right:50%:hidden', '?'), <bang>0)

let g:fzf_layout =
      \ { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1 } }
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

" -- YANK BANK --
let g:yb_yank_registers = ["j", "k", "l"]
let g:yb_clip_registers = ["x", "y", "z"]

" -- COC --
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Searhhi
let g:searchhi_clear_all_autocmds = 'InsertEnter'
let g:searchhi_update_all_autocmds = 'InsertLeave'
nmap <silent> <C-C> <Plug>(searchhi-clear-all)

let g:coc_global_extensions = [
      \ 'coc-solargraph',
      \ 'coc-vimlsp',
      \ 'coc-solargraph',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-clangd'
      \ ]

" -- MAPPINGS --
" Resize vertical split
noremap <c-h> <c-w><
noremap <c-l> <c-w>>
autocmd filetype netrw noremap <buffer> <c-l> <c-w>>
" Custom scroll
noremap <silent><c-u> :call <SID>scroll('up')<cr>
noremap <silent><c-d> :call <SID>scroll('down')<cr>

" Leader
map <Space> <leader>
nmap <leader>; <Plug>(easymotion-s)
nmap <leader>a :Ag<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>d :call AddDebugger("o")<cr>
nmap <leader>f :Files<cr>
nmap <leader>h :History<cr>
nmap <leader>s :Startify<cr>
nmap <leader>t :Tags<cr>
nmap <silent><leader>z :call <SID>zoom()<cr>
autocmd Filetype c nmap <leader>r
      \ :terminal gcc -Wall -std=c99 % -o out && ./out && rm out<CR>

" Others
tnoremap <C-\> <C-\><C-n>
nnoremap g] g<C-]>

" -- SIGNIFY --
let g:signify_sign_delete = '-'
let g:signify_sign_delete_first_line = '-'
let g:signify_sign_change = '~'
let g:signify_sign_show_count = 0
autocmd User SignifyAutocmds autocmd! signify FocusGained

"-- LINELETTERS --
let g:lineletters_settings = {
      \ 'highlight_group': 'MoreMsg',
      \ 'prefix_chars': [',', ';', 'j']
      \ }
map <silent>, <Plug>LineLetters

"-- MISC --
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.xml'
let g:html_indent_inctags = 'html,body,head,tbody,p,nav'
let g:searchant_all = 0
let g:searchant_map_stop = 0
command! Gblame Git<Space>blame

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

" scroll by 10 percent
function s:scroll(direction)
  let l:h = float2nr(0.1 * winheight('%'))

  if a:direction == "down"
    execute "normal! " . l:h . "\<C-E>"
  else
    execute "normal! " . l:h . "\<C-Y>"
  end
endfunction

"-- CUSTOM COLORS (keep at the end) --
hi rubyPseudoVariable ctermfg=9
hi rubyBoolean ctermfg=9
hi rubyDefine cterm=NONE ctermfg=2
hi Comment cterm=italic
hi StartifyPath ctermfg=11
hi StartifySlash ctermfg=11
hi link NormalFloat CursorColumn

hi link StartifyFile Normal
hi CocMenuSel ctermbg=237

hi VertSplit ctermbg=NONE guibg=NONE ctermfg=12
hi ErrorMsg cterm=NONE ctermfg=9 gui=bold guifg=Magenta
hi! link SignColumn LineNr
hi SpecialKey cterm=bold ctermfg=8 gui=bold guifg=Magenta
hi EasyMotionTarget2First ctermbg=none ctermfg=red
hi EasyMotionTarget2Second ctermbg=none ctermfg=red
hi Visual cterm=reverse ctermfg=11 ctermbg=0
hi MatchParen ctermbg=NONE cterm=NONE ctermfg=5
hi SignifySignDelete ctermfg=9 ctermbg=0
hi SignifySignDeleteFirstLine ctermfg=9 ctermbg=0
hi htmlTagName cterm=NONE ctermfg=6

"-- AUTOCOMMANDS --
autocmd Filetype c
      \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go
      \ setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" highlight all matches only while searching
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" disable Coc Linter while easymotion is active
autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd silent! CocEnable

vnoremap <leader>r "hy:%s/<C-r>h//gc<left><left><left>
