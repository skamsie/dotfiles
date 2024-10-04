vim.fn.setenv('TERM', 'xterm-256color')

-- NVIM SETTINGS
vim.g.mapleader = " "
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.opt.matchpairs:append("<:>")
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.colorcolumn = "80"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamed"

-- NETRW settings
vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 33
vim.g.netrw_localrmdir = 'rm -rf'

-- Resize vertical split
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>>', { noremap = true })

vim.cmd [[
  autocmd User AlphaReady set laststatus=0
  autocmd BufUnload <buffer> set laststatus=2

  " scroll by 10 percent
  function s:scroll(direction)
    let l:h = float2nr(0.1 * winheight('%'))

    execute "normal! " . l:h . (a:direction == 'down' ? "\<C-E>" : "\<C-Y>")
  endfunction

  " Custom scroll
  noremap <silent><c-u> :call <SID>scroll('up')<cr>
  noremap <silent><c-d> :call <SID>scroll('down')<cr>
]]

-- load plugins
require('config.lazy')
