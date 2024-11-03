return   {
  'norcalli/nvim-colorizer.lua',
  enabled = false,
  config = function()
    require 'colorizer'.setup({
      'css';
      'lua';
    }, { mode = 'foreground' })
  end
}
