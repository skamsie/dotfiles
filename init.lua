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
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamed"

-- Resize vertical split
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>>', { noremap = true })

vim.cmd [[
  " scroll by 10 percent
  function s:scroll(direction)
    let l:h = float2nr(0.1 * winheight('%'))

    execute "normal! " . l:h . (a:direction == 'down' ? "\<C-E>" : "\<C-Y>")
  endfunction

  " Custom scroll
  noremap <silent><c-u> :call <SID>scroll('up')<cr>
  noremap <silent><c-d> :call <SID>scroll('down')<cr>
]]

require("lazy").setup({
  spec = {
    -- Solarized colors
    {
      'maxmx03/solarized.nvim',
      lazy = false,
      priority = 1000,
      opts = {
        transparent = { enabled = true },
        on_colors = function()
          return {
            -- match .alacrittty.toml
            green  = '#9fb927',
            blue   = '#4b9ffc',
            cyan   = '#49b6a9',
            orange = '#e86c48',
            yellow = '#d09a27',
            violet = '#837CE4',
            base0 = '#a6b0b0',
            base01 = '#6b8287',
            magenta = '#cf598e'
          }
        end,
        on_highlights = function(colors, color)
          local lighten = color.lighten

          return {
            Boolean = { fg = colors.magenta },
            Changed = { fg = colors.yellow },
            Comment = { italic = true },
            Define = { fg = colors.green, bold = false },
            Identifier = { fg = colors.base0 },
            IncSearch = { bg = colors.red, fg = '#073642', bold = false },
            Normal = { fg = colors.base0 },
            Number = { fg = colors.magenta },
            Property = { fg = colors.base0 },
            Search = { bg = colors.yellow, fg = '#073642', bold = false },
            Type = { fg = colors.yellow },
            rubyFloat = { link = Number },
            rubyInteger = { link = Number },
            rubyMacro = { fg = colors.orange },
            rubyMagicComment = { fg = colors.orange },
            rubyPercentStringDelimiter = { fg = colors.violet },
            rubyString = { fg = colors.green },
            rubyStringDelimiter = { fg = colors.green },
            rubySymbol = { fg = colors.cyan },
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

    -- Because letters are much easier to touch type than numbers (๑˃̵ᴗ˂̵)و
    {
      'skamsie/vim-lineletters',
      init = function()
        vim.g.lineletters_settings = { prefix_chars = { ',', ';', 'j' } }
        vim.api.nvim_set_keymap('', ',', '<Plug>LineLetters', { silent = true })
      end
    },

    -- Highlight the current search result in a different style than the other search results.
    {
      'qxxxb/vim-searchhi',
      config = function()
        vim.g.searchhi_clear_all_autocmds = 'InsertEnter'
        vim.g.searchhi_update_all_autocmds = 'InsertLeave'
        vim.keymap.set('n', '<C-C>', '<Plug>(searchhi-clear-all)', { silent = true })
      end
    },

    -- Improved fzf.vim written in lua
    {
      "ibhagwan/fzf-lua",
      config = function()
        function set_fzf_keymap(key, func)
          vim.keymap.set(
            'n', '<leader>' .. key,
            function()
              require('fzf-lua')[func]()
            end,
            { noremap = true, silent = true }
          )
        end

        set_fzf_keymap('f', 'files')
        set_fzf_keymap('a', 'live_grep_native')

        -- calling `setup` is optional for customization
        require("fzf-lua").setup(
          {
            winopts = { row = 0.5, col = 0.5, width = 0.8, height = 0.8, border = 'single' },
            defaults = { file_icons = false },
            files = {},
          }
        )
      end
    },
  },
  install = { colorscheme = { 'solarized' } },
  checker = { enabled = true },
  ui = {
    border = 'single',
    icons = {
      list = {
        "●",
        "▸",
        "■",
        "*",
      },
    },
  }
})
