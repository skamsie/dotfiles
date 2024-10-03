-- Because letters are much easier to touch type than numbers
return {
  'skamsie/vim-lineletters',

  init = function()
    vim.g.lineletters_settings = { prefix_chars = { ',', ';', 'j' } }
    vim.api.nvim_set_keymap('', ',', '<Plug>LineLetters', { silent = true })
  end
}
