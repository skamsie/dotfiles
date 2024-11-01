return {
  { 'ntpeters/vim-better-whitespace' },
  {
    'alvan/vim-closetag',
    config = function()
      vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.xml'
    end
  },
  {
    'skamsie/vim-lineletters',
    init = function()
      vim.g.lineletters_settings = { prefix_chars = { ',', ';', 'j' } }
      vim.api.nvim_set_keymap('', ',', '<Plug>LineLetters', { silent = true })
    end
  },
  {
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
  }
}
