return {
  'alvan/vim-closetag',
  config = function()
    vim.g.searchhi_clear_all_autocmds = '*.html,*.xhtml,*.phtml,*.erb,*.xml'
  end
}
