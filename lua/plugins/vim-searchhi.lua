-- Highlight the current search result in a different style than the other search results.
return {
  'qxxxb/vim-searchhi',
  config = function()
    vim.g.searchhi_clear_all_autocmds = 'InsertEnter'
    vim.g.searchhi_update_all_autocmds = 'InsertLeave'
    vim.keymap.set('n', '<C-C>', '<Plug>(searchhi-clear-all)', { silent = true })
  end
}
