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
vim.opt.clipboard = 'unnamed'
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
  autocmd filetype netrw noremap <buffer> <c-l> <c-w>>
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

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.css", "*.scss" },
  callback = function()
    local current_dir = vim.fn.expand("%:p:h") -- Get the directory of the current file
    local target_dir = vim.fn.expand("~/github/skamsie/casetofoane")
    if current_dir:find(target_dir, 1, true) == 1 then
      vim.fn.jobstart("yarn build:css", { detach = true }) -- Run the shell command
    end
  end,
})

-- Go --
-- indentation (use tab and tab is 4 spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt.expandtab = false
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.smarttab = true
  end,
})
-- Auto-convert spaces to tabs on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  command = "silent! %retab!"
})

-- Disable the default startup screen
vim.opt.shortmess:append("I")

-- Disable default startup screen
vim.opt.shortmess:append("I")

-- Hide statusline and command line if no files are opened
if vim.fn.argc() == 0 then
    vim.opt.laststatus = 0
    vim.opt.cmdheight = 0
end

-- Ensure Alpha hides statusline and cmdheight, restoring them on exit
vim.api.nvim_create_autocmd("User", {
    pattern = "AlphaReady",
    command = "set laststatus=0 cmdheight=0 | autocmd BufUnload <buffer> set laststatus=2 cmdheight=1",
})

require('config.lazy')
require('config.statusline')
