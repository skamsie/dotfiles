-- NVIM SETTINGS
vim.g.mapleader = " "
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.opt.matchpairs:append("<:>")
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.colorcolumn = "80" vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.incsearch = true
vim.opt.clipboard = "unnamed"
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.showcmd = false

-- NETRW settings
vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 33
vim.g.netrw_localrmdir = 'rm -rf'
vim.g.netrw_keepj = ''

-- Resize vertical split
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>>', { noremap = true })

vim.fn.setenv("TERM", "xterm-256color")

vim.cmd [[
  " scroll by 10 percent
  function CustomScroll(direction)
    let l:h = float2nr(0.1 * winheight('%'))

    execute "normal! " . l:h . (a:direction == 'down' ? "\<C-E>" : "\<C-Y>")
  endfunction
]]

-- Custom scroll keymaps
vim.api.nvim_set_keymap(
  'n', '<C-u>', '', {
    noremap = true,
    silent = true,
    callback = function() vim.fn.CustomScroll('up') end
  }
)
vim.api.nvim_set_keymap(
  'n', '<C-d>', '', {
    noremap = true,
    silent = true,
    callback = function() vim.fn.CustomScroll('down') end
  }
)

require('config.lazy')
require('config.statusline')
