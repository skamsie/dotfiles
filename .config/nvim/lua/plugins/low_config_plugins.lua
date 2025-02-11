return {
  { 'ntpeters/vim-better-whitespace' },
  {
    'mcasper/vim-infer-debugger',
    config = function()
      vim.cmd[[
        nmap <leader>d :call AddDebugger('o')<cr>
      ]]
    end
  },
  {
    'alvan/vim-closetag',
    config = function()
      vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.xml,*vue'
    end
  },
  {
    'skamsie/vim-lineletters',
    init = function()
      vim.g.lineletters_settings = { prefix_chars = { ',', ';', 'j' } }
      vim.api.nvim_set_keymap('', ',', '<Plug>LineLetters', { silent = true })
    end
  },
  { -- Run tests from vim
    'janko-m/vim-test',
    config = function()
      vim.g['test#strategy'] = 'neovim'
    end
  },
  { -- Highlight the current search result in a different style than the other search results.
    'qxxxb/vim-searchhi',
    config = function()
      vim.g.searchhi_clear_all_autocmds = 'InsertEnter'
      vim.g.searchhi_update_all_autocmds = 'InsertLeave'
      vim.keymap.set('n', '<C-C>', '<Plug>(searchhi-clear-all)', { silent = true })
    end
  },
  {
    'skamsie/vim-yank-bank',
    init = function()
      vim.cmd[[
        let g:yb_yank_registers = ["j", "k", "l"]
        let g:yb_clip_registers = ["x", "y", "z"]
      ]]
    end
  },
  {
    'mhinz/vim-signify',
    config = function()
      vim.cmd[[
        let g:signify_sign_delete = '-'
        let g:signify_sign_delete_first_line = '-'
        let g:signify_sign_change = '~'
        let g:signify_sign_show_count = 0

        autocmd User SignifyAutocmds autocmd! signify FocusGained
      ]]
    end
  },
  -- A simple plugin that helps to end certain structures automatically
  'tpope/vim-endwise',
  -- A Git wrapper so awesome, it should be illegal
  'tpope/vim-fugitive',
  'tpope/vim-rails',
  'tpope/vim-rhubarb',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-eunuch',
  'AndrewRadev/splitjoin.vim'
}
