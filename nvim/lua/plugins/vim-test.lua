return {
  {
    'janko-m/vim-test',
    config = function()
      vim.g['test#strategy'] = 'neovim'
    end
  }
}
