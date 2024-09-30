-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- NVIM SETTINGS
vim.g.mapleader = " "
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.opt.matchpairs:append("<:>")
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.colorcolumn = "80"
vim.opt.hidden = true

-- Resize vertical split
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>>', { noremap = true })

-- Fzf-lua remappings
vim.keymap.set('n', '<leader>f', function() require('fzf-lua').files() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>a', function() require('fzf-lua').grep_project() end, { noremap = true, silent = true })



-- lineletters
vim.g.lineletters_settings = {
  highlight_group = 'Constant',
  prefix_chars = { ',', ';', 'j' }
}
-- Make sure vertical separator is a |
vim.opt.fillchars:append("vert:│")

-- Indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.incsearch = true  -- Equivalent to 'set incsearch'
vim.opt.hlsearch = false  -- Equivalent to 'set nohlsearch'
vim.opt.clipboard = "unnamed"

--vim.api.nvim_set_hl(0, 'ColorColumn', { link = 'NormalFloat' })
--vim.api.nvim_set_hl(0, 'rubyPseudoVariable', { ctermfg = 9, force = true })
--vim.api.nvim_set_hl(0, 'rubyBoolean', { ctermfg = 5 })
--vim.api.nvim_set_hl(0, 'rubyInteger', { ctermfg = 5 })
--vim.api.nvim_set_hl(0, 'rubyDefine', { ctermfg = 2, force = true })
--vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'CursorColumn', force = true })
--vim.api.nvim_set_hl(0, 'Function', { link = 'Identifier', force = true })
--vim.api.nvim_set_hl(0, 'Comment', { force = true, italic = true })

vim.api.nvim_set_hl(0, 'rubyMacro', { link = 'Type' })
vim.api.nvim_set_hl(0, 'rubyConstant', { link = 'Changed' })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Solarized colors
    {
      'maxmx03/solarized.nvim',
      lazy = false,
      priority = 1000,
      opts = {
        on_colors = function()
          return {
            -- match .alacrittty.toml
            green  = '#a1b928',
            blue   = '#5ea9fb',
            cyan   = '#46b5a8',
            orange = '#C95A38'
          }
        end
      },
      config = function(_, opts)
        vim.o.termguicolors = true
        vim.o.background = 'dark'
        require('solarized').setup(opts)
        vim.cmd.colorscheme 'solarized'
      end,
    },

    -- Vim Lineletters
    {
      'skamsie/vim-lineletters',
      vim.api.nvim_set_keymap('', ',', '<Plug>LineLetters', { silent = true })
    },

    -- Treesitter
   -- {
   --   "nvim-treesitter/nvim-treesitter",
   --   build = ":TSUpdate",
   --   config = function () 
   --     local configs = require("nvim-treesitter.configs")

   --     configs.setup({
   --       ensure_installed = { "c", "lua", "vim", "vimdoc", "elixir", "javascript", "html" },
   --       sync_install = false,
   --       highlight = { enable = true },
   --       indent = { enable = true },  
   --     })
   --   end
   -- },

    'tpope/vim-rails',

    -- FZF
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    },
  },
  install = { colorscheme = { 'solarized' } },
  checker = { enabled = true },
})
